class Oauth::UserController < ApplicationController
  def user
    # Why OmniAuth sends bearer_token instead of access token?
    if auth = Authorization.find_by_token(params[:bearer_token])
      render json: auth.user
    else
      render json: { message: 'Unauthorized Request' }, status: :unauthorized
    end
  end
end
