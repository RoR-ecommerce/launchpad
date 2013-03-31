class Client < ActiveRecord::Base
  validates :name, :client_id, :client_secret, :uri, :redirect_uri,
    presence: true

  before_validation :set_client_id, :set_client_secret, on: :create

  private

  def set_client_id
    self.client_id = SecureRandom.hex(10)
  end

  def set_client_secret
    self.client_secret = SecureRandom.hex(20)
  end
end
