class AddAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.integer :user_id, :client_id, null: false
      t.string  :access_token, :code, null: false
      t.timestamps
    end

    add_index :authorizations, :access_token, unique: true
    add_index :authorizations, :code,         unique: true
  end
end
