class SeedCountries < ActiveRecord::Migration
  class Country < ActiveRecord::Base; end

  def up
    YAML.load_file(Rails.root.join('db', 'seeds', 'countries.yml')).each do |country|
      Country.create!(country)
    end
  end

  def down
    Country.delete_all
  end
end
