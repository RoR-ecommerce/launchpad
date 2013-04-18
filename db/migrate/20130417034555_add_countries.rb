class AddCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string  :name,              null: false
      t.string  :iso_name,          null: false
      t.string  :alpha2,  limit: 2, null: false
      t.string  :alpha3,  limit: 3, null: false
      t.integer :numcode, limit: 3, null: false
      t.timestamps
    end
  end
end
