class Oauth::AuthController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :client_does_not_exist

  def auth
    client     = Client.find_one!(params[:client_id])
    redirector = UriRedirector.new(client.redirect_uri, params[:redirect_uri])

    # FIXME Bug
    # redirect_to does not understand additional paramethers when the first one
    # is string, so we need to create full string manually.
    # redirect_to(redirector.redirect_uri, state: params[:state])
    redirect_to("#{redirector.redirect_uri}?state=#{params[:state]}")
  end
end
