class Authorizator
  def initialize(user, client)
    @user   = user
    @client = client
  end

  def create!
    Authorization.where(user_id: @user, client_id: @client).first_or_create!
  end
end
