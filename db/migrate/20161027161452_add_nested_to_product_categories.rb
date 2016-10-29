class AddNestedToProductCategories < ActiveRecord::Migration[5.0]
  def up
    add_column :product_categories, :parent_id, :integer
    add_column :product_categories, :lft, :integer
    add_column :product_categories, :rgt, :integer
    add_column :product_categories, :depth, :integer

    add_index :product_categories, :lft
    add_index :product_categories, :rgt

    add_column :product_categories, :ancestral_permalink, :string
    add_column :product_categories, :permalink_includes_ancestors, :boolean, default: false

    ProductCategory.reset_column_information
    ProductCategory.rebuild!
  end

  def down
    remove_column :product_categories, :ancestral_permalink
    remove_column :roduct_categories, :permalink_includes_ancestors

    remove_index :product_categories, :lft
    remove_index :product_categories, :rgt

    remove_column :product_categories, :parent_id
    remove_column :product_categories, :lft
    remove_column :product_categories, :rgt
    remove_column :product_categories, :depth
  end
end
