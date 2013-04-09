class App < ActiveRecord::Base
  validates :name, :client_id, :client_secret, :uri, :redirect_uri,
    presence: true

  validates :client_id, :client_secret, :uri, :redirect_uri,
    uniqueness: true

  before_validation :set_client_id, :set_client_secret,
    on: :create

  class << self
    def authorize!(client_id)
      where(client_id: client_id).first!
    end
  end

  private

  def set_client_id
    self.client_id = SecureRandom.hex(20)
  end

  def set_client_secret
    self.client_secret = SecureRandom.hex(20)
  end
end
