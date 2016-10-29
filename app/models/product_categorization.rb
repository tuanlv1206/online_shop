class ProductCategorization < ActiveRecord::Base

  # Links back
  belongs_to :product
  belongs_to :product_category

  # Validations
  validates_presence_of :product, :product_category
end

