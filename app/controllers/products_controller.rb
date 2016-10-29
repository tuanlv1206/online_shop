class ProductsController < ApplicationController
  before_filter { params[:id] && @product = Product.root.find(params[:id]) }

  def index
    @products_paged = Product.root
                                 .includes(:translations, :stock_level_adjustments, :product_categories, :variants)
                                 .order(:name)
    if params[:category_id].present?
      @products_paged = @products_paged
                        .where('product_categorizations.product_category_id = ?', params[:category_id])
    end

    case
    when params[:sku]
      @products_paged = @products_paged
                        .with_translations(I18n.locale)
                        .page(params[:page])
                        .ransack(sku_cont_all: params[:sku].split).result
    when params[:name]
      @products_paged = @products_paged
                        .with_translations(I18n.locale)
                        .page(params[:page])
                        .ransack(translations_name_or_translations_description_cont_all: params[:name].split)
                        .result
    else
      @products_paged = @products_paged.page(params[:page])
    end

    @products = @products_paged
                .group_by(&:product_category)
                .sort_by { |cat, _pro| cat.name }
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(safe_params)
    if @product.save
      redirect_to :products, flash: { notice: t('shop.products.create_notice') }
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @product.update(safe_params)
      redirect_to [:edit, @product], flash: { notice: t('shop.products.update_notice') }
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to :products, flash: { notice: t('shop.products.destroy_notice') }
  end

  def import
    if request.post?
      if params[:import].nil?
        redirect_to import_products_path, flash: { alert: t('shop.imports.errors.no_file') }
      else
        Product.import(params[:import][:import_file])
        redirect_to products_path, flash: { notice: t('shop.products.imports.success') }
      end
    end
  end

  private

  def safe_params
    file_params = [:file, :parent_id, :role, :parent_type, file: []]
    params[:product].permit(:name, :sku, :permalink, :description, :short_description, :weight, :price, :cost_price, :tax_rate_id, :stock_control, :active, :featured, :in_the_box, attachments: [default_image: file_params, data_sheet: file_params, extra: file_params], product_attributes_array: [:key, :value, :searchable, :public], product_category_ids: [])
  end
end
