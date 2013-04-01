class Client < ActiveRecord::Base
  has_many :authorizations, inverse_of: :client, dependent: :destroy

  validates :name, :client_id, :client_secret, :uri, :redirect_uri,
    presence: true

  validates :client_id, :client_secret, :uri, :redirect_uri,
    uniqueness: true

  before_validation :set_client_id, :set_client_secret, on: :create

  scope :secret, -> (client_id, client_secret) \
    { where(client_id: client_id, client_secret: client_secret) }

  private

  def set_client_id
    self.client_id = SecureRandom.hex(10)
  end

  def set_client_secret
    self.client_secret = SecureRandom.hex(20)
  end
end
