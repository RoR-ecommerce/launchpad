class AddLegacyUserFieldsForMigration < ActiveRecord::Migration
  def change
    add_column :users, :old_crypted_password, :string
    add_column :users, :old_password_salt, :string
  end
end
