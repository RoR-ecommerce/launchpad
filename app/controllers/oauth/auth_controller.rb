class Oauth::AuthController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :client_does_not_exist

  # TODO Security
  # Spoofing protection to make sure that requests to create action are coming
  # from our new action.
  # This will prevent malicious clients from trying to spoof our internals.
  #
  # Could be implemented the same way as Rails CSRF protection.

  def new
    client = Client.where(client_id: params[:client_id]).first!

    redirect_to oauth_auth_path(
      client_id: client.client_id, redirect_uri: params[:redirect_uri],
      state: params[:state])
  end

  def create
    client       = Client.where(client_id: params[:client_id]).first!
    authorizator = Authorizator.new(current_user, client).create!
    redirector   = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    redirect_to(redirector.redirect_uri,
      state: params[:state], code: authorizator.code)
  end

  private

  def client_does_not_exist
    redirect_to root_path
  end
end
