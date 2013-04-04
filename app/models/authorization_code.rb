class AuthorizationCode < ActiveRecord::Base
  CODE_TTL = 2.minutes

  belongs_to :user

  validates :client_id, :client_secret, :user_id, :access_token,
    presence: true

  validates :code,
    uniqueness: true

  before_validation :set_code, :set_code_expiration,
    on: :create

  scope :expired,     -> { where('code_expires_at <= ?', Time.current) }
  scope :not_expired, -> { where('code_expires_at >= ?', Time.current) }

  scope :by_client_and_code, ->(client_id, client_secret, code) \
    { where(client_id: client_id, client_secret: client_secret, code: code) }

  class << self
    def authorize(client_id, client_secret, code)
      not_expired.by_client_and_code(client_id, client_secret, code).first
    end

    def cleanup!
      expired.delete_all
    end
  end

  private

  def set_code
    self.code = SecureRandom.hex(20)
  end

  def set_code_expiration
    self.code_expires_at = CODE_TTL.from_now
  end
end
