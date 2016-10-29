class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string   :token
      t.string   :first_name
      t.string   :last_name
      t.string   :company
      t.string   :billing_address1
      t.string   :billing_address2
      t.string   :billing_address3
      t.string   :billing_address4
      t.string   :billing_postcode
      t.integer  :billing_country_id
      t.string   :email_address
      t.string   :phone_number
      t.string   :status
      t.datetime :received_at
      t.datetime :accepted_at
      t.datetime :shipped_at
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :delivery_service_id
      t.decimal  :delivery_price,            precision: 8, scale: 2
      t.decimal  :delivery_cost_price,       precision: 8, scale: 2
      t.decimal  :delivery_tax_rate,         precision: 8, scale: 2
      t.decimal  :delivery_tax_amount,       precision: 8, scale: 2
      t.datetime :paid_at
      t.integer  :accepted_by
      t.integer  :shipped_by
      t.string   :consignment_number
      t.datetime :rejected_at
      t.integer  :rejected_by
      t.string   :ip_address
      t.string   :payment_reference
      t.string   :payment_method
      t.text     :notes
      t.boolean  :separate_delivery_address, default: false
      t.string   :delivery_name
      t.string   :delivery_address1
      t.string   :delivery_address2
      t.string   :delivery_address3
      t.string   :delivery_address4
      t.string   :delivery_postcode
      t.integer  :delivery_country_id

      t.timestamps
    end
  end
end
