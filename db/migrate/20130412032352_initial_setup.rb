class InitialSetup < ActiveRecord::Migration
  def up
    create_table "apps", :force => true do |t|
      t.string   "name",          :null => false
      t.string   "client_id",     :null => false
      t.string   "client_secret", :null => false
      t.string   "uri",           :null => false
      t.string   "redirect_uri",  :null => false
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
    end

    add_index "apps", ["client_id"], :name => "index_clients_on_client_id", :unique => true
    add_index "apps", ["client_secret"], :name => "index_clients_on_client_secret", :unique => true

    create_table "authorization_codes", :force => true do |t|
      t.string   "client_id"
      t.string   "client_secret"
      t.string   "code"
      t.integer  "user_id"
      t.datetime "code_expires_at"
      t.datetime "created_at",      :null => false
      t.datetime "updated_at",      :null => false
      t.string   "access_token",    :null => false
    end

    add_index "authorization_codes", ["client_id", "client_secret"], :name => "index_authorization_codes_on_client_id_and_client_secret"
    add_index "authorization_codes", ["code"], :name => "index_authorization_codes_on_code", :unique => true

    create_table "users", :force => true do |t|
      t.string   "email",                                  :null => false
      t.string   "encrypted_password",                     :null => false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.datetime "created_at",                             :null => false
      t.datetime "updated_at",                             :null => false
      t.string   "access_token",                           :null => false
      t.datetime "deleted_at"
      t.uuid     "uid",                                    :null => false
      t.string   "full_name",                              :null => false
    end

    add_index "users", ["access_token"], :name => "index_users_on_access_token", :unique => true
    add_index "users", ["email"], :name => "index_users_on_email", :unique => true
    add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
    add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
