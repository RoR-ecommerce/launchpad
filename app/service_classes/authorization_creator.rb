class AuthorizationCreator
  def initialize(user, app)
    @user = user
    @app  = app
  end

  def create!
    AuthorizationCode.create! do |auth_code|
      auth_code.user_id       = @user.id
      auth_code.access_token  = @user.access_token
      auth_code.client_id     = @app.client_id
      auth_code.client_secret = @app.client_secret
    end
  end
end
