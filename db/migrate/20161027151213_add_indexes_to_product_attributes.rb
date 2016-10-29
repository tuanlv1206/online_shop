class AddIndexesToProductAttributes < ActiveRecord::Migration[5.0]
  def change
    add_index :product_attributes, :product_id
    add_index :product_attributes, :key
    add_index :product_attributes, :position
  end
end
