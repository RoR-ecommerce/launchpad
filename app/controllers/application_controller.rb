class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  private

  def client_does_not_exist
    redirect_to root_path
  end
end
