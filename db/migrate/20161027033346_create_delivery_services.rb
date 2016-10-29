class CreateDeliveryServices < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_services do |t|
      t.string :name
      t.string :code
      t.boolean :default, default: false
      t.boolean :active, default: true
      t.datetime :created_at
      t.datetime :updated_at
      t.string :courier
      t.string :tracking_url

      t.timestamps
    end
  end
end
