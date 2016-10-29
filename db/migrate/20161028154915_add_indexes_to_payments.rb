class AddIndexesToPayments < ActiveRecord::Migration[5.0]
  def change
    add_index :payments, :order_id
    add_index :payments, :parent_payment_id
  end
end
