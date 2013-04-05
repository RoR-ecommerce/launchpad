class RenameColumns < ActiveRecord::Migration
  def up
    remove_index :authorization_codes, [:client_id, :client_secret]
    rename_column :authorization_codes, :client_id, :app_id
    rename_column :authorization_codes, :client_secret, :app_secret
    add_index :authorization_codes, [:app_id, :app_secret]

    remove_index :clients, :client_id
    remove_index :clients, :client_secret
    rename_column :clients, :client_id, :app_id
    rename_column :clients, :client_secret, :app_secret
    add_index :clients, :app_id, unique: true
    add_index :clients, :app_secret, unique: true
  end

  def down
    remove_index :authorization_codes, [:app_id, :app_secret]
    rename_column :authorization_codes, :app_id, :client_id
    rename_column :authorization_codes, :app_secret, :client_secret
    add_index :authorization_codes, [:client_id, :client_secret]

    remove_index :clients, :app_id
    remove_index :clients, :app_secret
    rename_column :clients, :app_id, :client_id
    rename_column :clients, :app_secret, :client_secret
    add_index :clients, :client_id, unique: true
    add_index :clients, :client_secret, unique: true
  end
end
