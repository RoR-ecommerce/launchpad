class Oauth::AuthController < ApplicationController
  before_filter :authenticate_user!

  def auth
    client     = Client.find!(params[:client_id])
    auth       = Authorization.create!(user: current_user, client: client)
    redirector = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    redirect_to redirector.uri \
      state: params[:state], code: auth.code, response_type: 'code'
  end
end
