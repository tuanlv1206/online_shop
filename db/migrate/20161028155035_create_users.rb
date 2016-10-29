class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string   :first_name
      t.string   :last_name
      t.string   :email_address
      t.string   :password_digest
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
