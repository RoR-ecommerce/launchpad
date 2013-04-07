class Oauth::AuthController < ApplicationController
  before_filter :authenticate_user!

  def auth
    app        = App.authorize!(params[:client_id])
    auth       = AuthorizationCreator.new(current_user, app).create!
    redirector = UriRedirector.new(app.redirect_uri, params[:redirect_uri])

    redirect_to redirector.uri \
      code: auth.code, response_type: 'code', state: params[:state]
  end

  # TODO Error response
  # Make error response if Client is not found, 404?
end
