class AddIndexToProducts < ActiveRecord::Migration[5.0]
  def change
    add_index :products, :parent_id
    add_index :products, :sku
    add_index :products, :product_category_id
    add_index :products, :permalink
  end
end
