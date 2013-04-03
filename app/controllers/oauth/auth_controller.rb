class Oauth::AuthController < ApplicationController
  before_filter :authenticate_user!

  def auth
    client     = Client.find!(params[:client_id])
    # Move into service?
    auth       = Authorization.where(user_id: current_user.id, client_id: client.id).first_or_create!
    redirector = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    redirect_to redirector.uri \
      state: params[:state], code: auth.code, response_type: 'code'
  end
end
