class Oauth::AuthController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :client_does_not_exist

  def auth
    client     = Client.find_one!(params[:client_id])
    redirector = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    redirect_to(redirector.uri(state: params[:state]))
  end
end
