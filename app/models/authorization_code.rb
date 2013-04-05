class AuthorizationCode < ActiveRecord::Base
  CODE_TTL = 2.minutes

  belongs_to :user

  validates :app_id, :app_secret, :user_id, :access_token,
    presence: true

  validates :code,
    uniqueness: true

  before_validation :set_code, :set_code_expiration,
    on: :create

  scope :expired,     -> { where('code_expires_at <= ?', Time.current) }
  scope :not_expired, -> { where('code_expires_at >= ?', Time.current) }

  scope :by_client_and_code, ->(app_id, app_secret, code) \
    { where(app_id: app_id, app_secret: app_secret, code: code) }

  class << self
    def authorize(app_id, app_secret, code)
      not_expired.by_client_and_code(app_id, app_secret, code).first
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
