class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer  :order_id
      t.integer  :ordered_item_id
      t.string   :ordered_item_type
      t.integer  :quantity, default: 1
      t.decimal  :unit_price,        precision: 8, scale: 2
      t.decimal  :unit_cost_price,   precision: 8, scale: 2
      t.decimal  :tax_amount,        precision: 8, scale: 2
      t.decimal  :tax_rate,          precision: 8, scale: 2
      t.decimal  :weight,            precision: 8, scale: 3, default: nil
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
