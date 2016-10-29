class CreateProductCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :product_categories do |t|
      t.string   :name
      t.string   :permalink
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
