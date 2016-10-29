class CreateStockLevelAdjustments < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_level_adjustments do |t|
      t.integer  :item_id
      t.string   :item_type
      t.string   :description
      t.integer  :adjustment, default: 0
      t.string   :parent_type
      t.integer  :parent_id
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
