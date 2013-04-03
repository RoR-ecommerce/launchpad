class Oauth::UserController < ApplicationController
  def user
    if auth = Authorization.find_by_token(params[:access_token])
      render json: auth.user
    else
      render json: { message: 'Unauthorized Request' }, status: :unauthorized
    end
  end
end
