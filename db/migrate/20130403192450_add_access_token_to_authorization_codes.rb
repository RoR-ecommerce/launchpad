class AddAccessTokenToAuthorizationCodes < ActiveRecord::Migration
  class AuthorizationCode < ActiveRecord::Base; end

  def up
    AuthorizationCode.delete_all
    add_column :authorization_codes, :access_token, :string, null: false
  end

  def down
    remove_column :authorization_codes, :access_token
  end
end
