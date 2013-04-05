# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130405043103) do

  create_table "authorization_codes", :force => true do |t|
    t.string   "app_id"
    t.string   "app_secret"
    t.string   "code"
    t.integer  "user_id"
    t.datetime "code_expires_at"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "access_token",    :null => false
  end

  add_index "authorization_codes", ["app_id", "app_secret"], :name => "index_authorization_codes_on_app_id_and_app_secret"
  add_index "authorization_codes", ["code"], :name => "index_authorization_codes_on_code", :unique => true

  create_table "clients", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "app_id",       :null => false
    t.string   "app_secret",   :null => false
    t.string   "uri",          :null => false
    t.string   "redirect_uri", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "clients", ["app_id"], :name => "index_clients_on_app_id", :unique => true
  add_index "clients", ["app_secret"], :name => "index_clients_on_app_secret", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "access_token",                           :null => false
  end

  add_index "users", ["access_token"], :name => "index_users_on_access_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
