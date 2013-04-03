class Client < ActiveRecord::Base
  has_many :authorizations, inverse_of: :client, dependent: :delete_all

  validates :name, :client_id, :client_secret, :uri, :redirect_uri,
    presence: true

  validates :client_id, :client_secret, :uri, :redirect_uri,
    uniqueness: true

  before_validation :set_client_id, :set_client_secret,
    on: :create

  scope :with_secret, -> (client_id, client_secret) \
    { where(client_id: client_id, client_secret: client_secret) }

  class << self
    def find!(client_id)
      where(client_id: client_id).first!
    end

    def secure_find!(client_id, client_secret)
      with_secret(client_id, client_secret).first!
    end
  end

  private

  def set_client_id
    self.client_id = SecureRandom.hex(10)
  end

  def set_client_secret
    self.client_secret = SecureRandom.hex(20)
  end
end
