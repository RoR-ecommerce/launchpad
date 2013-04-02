class Oauth::TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :client_does_not_exist

  def create
    client = Client.find_one_with_secret!(params[:client_id], params[:client_secret])

    if client
      render json: { access_token: client.access_token, token_type: 'bearer' }
    else
      render json: { message: 'Authorization is not found' }, status: :unauthorized
    end
  end
end
