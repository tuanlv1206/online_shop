class AddIndexesToStockLevelAdjustments < ActiveRecord::Migration[5.0]
  def change
    add_index :stock_level_adjustments, [:item_id, :item_type], name: 'index_stock_level_adjustments_items'
    add_index :stock_level_adjustments, [:parent_id, :parent_type], name: 'index_stock_level_adjustments_parent'
  end
end
