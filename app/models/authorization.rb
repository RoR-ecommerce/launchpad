class Authorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :client

  validates :user_id, :client_id, :access_token, :code,
    presence: true

  validates :client_id,
    uniqueness: { scope: :user_id }

  validates :access_token, :code,
    uniqueness: true

  before_validation :set_access_token, :set_code,
    on: :create

  class << self
    def find_by_code(code)
      where(code: code).first
    end

    def find_by_token(token)
      where(access_token: token).first
    end
  end

  private

  def set_access_token
    self.access_token = SecureRandom.hex(20)
  end

  def set_code
    self.code = SecureRandom.hex(20)
  end
end
