class Oauth::UserController < ApplicationController
  before_filter :authorize!

  def user
    if stale?(etag: @user, last_modified: @user.updated_at, public: false)
      render json: @user
    end
  end

  private

  def authorize!
    @user = User.authorize_with_token(params[:access_token])
    unauthorized! unless @user
  end
end
