class Oauth::AuthController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize!

  def auth
    auth       = AuthorizationCreator.new(current_user, @app).create!
    redirector = UriRedirector.new(@app.redirect_uri, params[:redirect_uri])

    redirect_to redirector.uri \
      code: auth.code, response_type: 'code', state: params[:state]
  end

  private

  def authorize!
    @app = App.authorize!(params[:client_id])
    unauthorized! unless @app
  end
end
