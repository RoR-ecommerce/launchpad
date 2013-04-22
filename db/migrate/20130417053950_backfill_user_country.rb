class BackfillUserCountry < ActiveRecord::Migration
  class User < ActiveRecord::Base; end
  class Country < ActiveRecord::Base; end

  def up
    add_column :users, :country_id, :integer, after: :access_token

    country = Country.where(alpha3: 'USA').first!
    User.where(country_id: nil).update_all(country_id: country.id)

    change_column :users, :country_id, :integer, null: false
  end

  def down
    remove_column :users, :country_id
  end
end
