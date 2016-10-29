namespace :shop do

  desc 'Import default set of countries'
  task import_countries: :environment do
    CountryImporter.import
  end
end
