class AddIndexesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_index :users, :email_address
  end
end
