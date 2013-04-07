class Oauth::TokenController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authorize!

  def create
    render json: { access_token: @auth.access_token, token_type: 'bearer' }
  end

  private

  def authorize!
    @auth = AuthorizationCode.authorize \
      params[:client_id], params[:client_secret], params[:code]
    unauthorized! unless @auth
  end
end
