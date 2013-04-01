class Oauth::AuthController < ApplicationController
  before_filter :spoofing_check, only: :create

  rescue_from ActiveRecord::RecordNotFound, with: :client_does_not_exist

  def new
    client = Client.find_by_client_id(params[:client_id])
    redirect_to oauth_auth_path(
      client_id: client.client_id, redirect_uri: params[:redirect_uri],
      state: params[:state])
  end

  def create
    client       = Client.find(params[:client_id])
    authorizator = Authorizator.new(current_user, client).create!
    redirector   = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    redirect_to(redirector.redirect_uri,
      state: params[:state], code: authorizator.code)
  end

  private

  def spoofing_check
    redirect_to root_path unless
      SpoofingMatcher.new(request.referrer, request.url).match?
  end

  def client_does_not_exist
    redirect_to root_path
  end
end
