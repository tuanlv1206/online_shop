class AddIndexesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_index :orders, :token
    add_index :orders, :delivery_service_id
    add_index :orders, :received_at
  end
end
