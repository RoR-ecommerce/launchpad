class AuthorizationCreator
  def initialize(user, client)
    @user   = user
    @client = client
  end

  def create!
    AuthorizationCode.create! do |auth_code|
      auth_code.user_id       = @user.id
      auth_code.access_token  = @user.access_token
      auth_code.client_id     = @client.client_id
      auth_code.client_secret = @client.client_secret
    end
  end
end
