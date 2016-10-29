class AddIndexesToDeliveryServices < ActiveRecord::Migration[5.0]
  def change
    add_index :delivery_services, :active
    add_index :delivery_service_prices, :delivery_service_id
    add_index :delivery_service_prices, :min_weight
    add_index :delivery_service_prices, :max_weight
    add_index :delivery_service_prices, :price
  end
end
