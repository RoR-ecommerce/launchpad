class Oauth::AuthController < ApplicationController
  before_filter :authenticate_user!

  def auth
    app        = App.authorize!(params[:client_id])
    auth       = AuthorizationCreator.new(current_user, app).create!
    redirector = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    redirect_to redirector.uri \
      state: params[:state], code: auth.code, response_type: 'code'
  end
end
