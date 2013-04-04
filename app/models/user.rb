class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  has_many :authorization_codes, inverse_of: :user, dependent: :delete_all

  validates :access_token,
    uniqueness: true

  before_validation :set_access_token,
    on: :create

  class << self
    def authorize_with_token(token)
      where(access_token: token).first
    end
  end

  private

  def set_access_token
    self.access_token = SecureRandom.hex(20)
  end
end
