class AddUuidToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base; end

  def up
    User.delete_all
    add_column :users, :uid, :uuid, null: false, before: :email
    add_index  :users, :uid, unique: true
  end

  def down
    remove_index  :users, :uid
    remove_column :users, :uid
  end
end
