class AuthorizationCreator
  def initialize(user, client)
    @user   = user
    @client = client
  end

  def create!
    AuthorizationCode.create! do |auth_code|
      auth_code.user_id      = @user.id
      auth_code.access_token = @user.access_token
      auth_code.app_id       = @client.app_id
      auth_code.app_secret   = @client.app_secret
    end
  end
end
