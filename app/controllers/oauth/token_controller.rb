class Oauth::TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    auth = AuthorizationCode.authorize \
      params[:client_id], params[:client_secret], params[:code]

    if auth
      render json: { access_token: auth.access_token, token_type: 'bearer' }
    else
      render json: { message: 'Unauthorized Request' }, status: :unauthorized
    end
  end
end
