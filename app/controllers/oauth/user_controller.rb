class Oauth::UserController < ApplicationController
  def user
    if user = User.authorize_with_token(params[:access_token])
      render json: user
    else
      render json: { message: 'Unauthorized Request' }, status: :unauthorized
    end
  end
end
