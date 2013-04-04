class AddAuthorizationCodes < ActiveRecord::Migration
  def up
    create_table :authorization_codes do |t|
      # client_secret is for denormalization
      t.string   :client_id, :client_secret, :code
      t.integer  :user_id
      t.datetime :code_expires_at
      t.timestamps
    end

    add_index :authorization_codes, [:client_id, :client_secret]
    add_index :authorization_codes, :code, unique: true
  end

  def down
    drop_table :authorization_codes
  end
end
