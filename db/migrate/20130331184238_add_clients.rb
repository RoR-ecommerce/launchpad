class AddClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, :client_id, :client_secret, :uri, :redirect_uri, null: false
      t.timestamps
    end

    add_index :clients, :client_id, unique: true
    add_index :clients, :client_secret, unique: true
  end
end
