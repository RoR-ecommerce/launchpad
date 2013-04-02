class AddClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, :client_id, :client_secret, :access_token, :uri,
        :redirect_uri, null: false
      t.timestamps
    end

    add_index :clients, :client_id,     unique: true
    add_index :clients, :client_secret, unique: true
    add_index :clients, :access_token,  unique: true
  end
end
