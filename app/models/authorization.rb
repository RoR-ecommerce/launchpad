class Authorization < ActiveRecord::Base
  CODE_EXPIRATION_INTERVAL = 2.minutes

  belongs_to :user
  belongs_to :client

  validates :client_id, :user_id, :access_token, :code, :code_expires_at,
    presence: true

  validates :client_id, uniqueness: { scope: :user_id }
  validates :access_token, :code, uniqueness: true

  before_validation :set_access_token, :set_code, :set_code_expires_at,
    on: :create

  scope :with_code, -> (code) { where(code: code) }
  scope :not_expired, -> { where('code_expires_at >= ?', Time.current) }

  class << self
    def find_secretly(code, client_id, client_secret)
      joins(:client).not_expired.with_code(code).
        merge(Client.secret(client_id, client_secret)).last
    end
  end

  private

  def set_access_token
    self.access_token = SecureRandom.hex(20)
  end

  def set_code
    self.code = SecureRandom.hex(10)
  end

  def set_code_expires_at
    self.code_expires_at = CODE_EXPIRATION_INTERVAL.from_now
  end
end
