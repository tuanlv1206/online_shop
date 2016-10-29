class AddIndexesToOrderItems < ActiveRecord::Migration[5.0]
  def change
    add_index :order_items, [:ordered_item_id, :ordered_item_type], name: 'index_order_items_ordered_item'
    add_index :order_items, :order_id
  end
end
