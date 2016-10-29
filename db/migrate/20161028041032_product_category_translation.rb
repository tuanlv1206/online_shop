class ProductCategoryTranslation < ActiveRecord::Migration[5.0]
  def up
    ProductCategory.create_translation_table! name: :string, permalink: :string, description: :text

    ProductCategory.all.each do |pc|
      l = pc.translations.new
      l.locale = 'en'
      l.name = pc.name
      l.permalink = pc.permalink
      l.description = pc.description
      l.save!
    end
  end

  def down
    ProductCategory.drop_translation_table!
  end
end
