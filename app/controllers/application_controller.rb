class ApplicationController < ActionController::Base
  protect_from_forgery
  ensure_security_headers

  protected

  def unauthorized!
    render(json: { message: 'Unauthorized Request' }, status: :unauthorized) and return
  end
end
