class AddAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer  :user_id, :client_id, null: false
      t.string   :code, :access_token, null: false
      t.datetime :code_expires_at,     null: false
      t.timestamps
    end

    add_index :authorizations, [:user_id, :client_id], unique: true
    add_index :authorizations, :access_token, unique: true
    add_index :authorizations, :code, unique: true
  end
end
