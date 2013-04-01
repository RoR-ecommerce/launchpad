class Oauth::TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token, :authenticate_user!

  def create
    authorization = Authorization.find_secretly(
      params[:code], params[:client_id], params[:client_secret])

    if authorization
      render json: { access_token: authorization.access_token, token_type: 'bearer' }
    else
      render json: { message: 'Authorization is not found' }, status: :unauthorized
    end
  end
end
