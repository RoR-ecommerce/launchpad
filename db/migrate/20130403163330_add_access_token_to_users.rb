class AddAccessTokenToUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base; end

  def up
    User.destroy_all
    add_column :users, :access_token, :string, null: false
    add_index  :users, :access_token, unique: true
  end

  def down
    remove_column :users, :access_token
  end
end
