class ProductCategoriesController < ApplicationController
  before_action :find_product_category, only: [:edit, :update, :destroy]

  def index
    @product_categories_without_parent = ProductCategory.without_parent.ordered
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
    if @product_category.save
      redirect_to :product_categories, flash: { notice: t('shop.product_category.create_notice') }
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @product_category.update(product_category_params)
      redirect_to [:edit, @product_category], flash: { notice: t('shop.product_category.update_notice') }
    else
      render 'edit'
    end
  end

  def destroy
    @product_category.destroy
    redirect_to :product_categories, flash: { notice: t('shop.product_category.destroy_notice') }
  end

  private
  def find_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def product_category_params
    file_params = [:file, :parent_id, :role, :parent_type, file: []]
    params.require(:product_category).permit(:name, :permalink, :description, :parent_id, :permalink_includes_ancestors, attachments: [image: file_params])
  end
end
