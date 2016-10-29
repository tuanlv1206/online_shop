class VariantsController < ApplicationController
  before_action :find_product
  before_action :find_variants, only: [:edit, :update, :destroy]

  def index
    @variants = @product.variants.ordered
  end

  def new
    @variant = @product.variants.build
    render 'form'
  end

  def create
    @variant = @product.variants.build(product_params)
    if @variant.save
      redirect_to [@product, :variants], notice: t('shop.variants.create_notice')
    else
      render 'form'
    end
  end

  def edit
    render 'form'
  end

  def update
    if @variant.update(product_params)
      redirect_to edit_product_variant_path(@product, @variant), notice: t('shop.variants.update_notice')
    else
      render 'form'
    end
  end

  def destroy
    @variant.destroy
    redirect_to [@product, :variants], notice: t('shop.variants.destroy_notice')
  end

  private
  def find_product
    @product = Product.find(params[:product_id])
  end

  def find_variants
    @variant = @product.variants.find(params[:id])
  end

  def product_params
    params[:product].permit(:name, :permalink, :sku, :default_image_file, :price, :cost_price, :tax_rate_id, :weight, :stock_control, :active, :default)
  end
end
