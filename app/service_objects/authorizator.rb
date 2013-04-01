class Authorizator
  def initialize(user, client)
    @user   = user
    @client = client
  end

  def create!
    Authorization.create!(user: @user, client: @client)
  end
end
