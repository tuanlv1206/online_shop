class AllowMultipleProductsPerProductCategory < ActiveRecord::Migration[5.0]
  def up

    # create our join table first before we migrate
    # we have an id to allow :restrict_with_exception on product_category
    create_table :product_categorizations do |t|
      t.integer :product_id, null: false
      t.integer :product_category_id, null: false
    end

    add_index :product_categorizations, :product_id, name: 'categorization_by_product_id'
    add_index :product_categorizations, :product_category_id, name: 'categorization_by_product_category_id'

    # define the old belongs_to association (as it's no longer on the model)
    Product.class_eval do
      belongs_to :old_category,
                 class_name: 'ProductCategory',
                 foreign_key: 'product_category_id'
    end

    # migrate over to our new join table
    Product.all.each do |product|
      product.product_categories << product.old_category
      product.save
    end

    # lastly, remove the old product_category_id and associated index
    remove_index :products, :product_category_id if index_exists?(:products, :product_category_id)
    remove_column :products, :product_category_id
  end

  def down
    # first, we re-add our column so we've got something to populate
    add_column :products, :product_category_id, :integer
    add_index :products, :product_category_id
    # define the old belongs_to association once again as we're going to re-add our goodies
    Product.class_eval do
      belongs_to :new_category,
                 class_name: 'ProductCategory',
                 foreign_key: 'product_category_id'
    end
    # migrate over from the new table to the old association
    Product.all.each do |product|
      next unless product.product_categories.count
      product.new_category = product.product_categories.first
      product.save
    end
    # drop our join table
    drop_table :product_categorizations
  end
end
