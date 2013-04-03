class Oauth::TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_client!

  def create
    if auth = Authorization.find_by_code(params[:code])
      render json: { access_token: auth.access_token, token_type: 'bearer' }
    else
      render json: { message: 'Unauthorized Request' }, status: :unauthorized
    end
  end

  private

  def authenticate_client!
    Client.secure_find!(params[:client_id], params[:client_secret])
  end
end
