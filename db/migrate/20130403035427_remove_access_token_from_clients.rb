class RemoveAccessTokenFromClients < ActiveRecord::Migration
  def up
    remove_column :clients, :access_token
  end

  def down
    add_column :clients, :access_token, :string, null: false
    add_index :clients, :access_token,  unique: true
  end
end
