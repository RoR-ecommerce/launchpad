class Oauth::AuthController < ApplicationController
  before_filter :authenticate_user!

  def auth
    client     = Client.authorize!(params[:app_id])
    auth       = AuthorizationCreator.new(current_user, client).create!
    redirector = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    redirect_to redirector.uri \
      state: params[:state], code: auth.code, response_type: 'code'
  end
end
