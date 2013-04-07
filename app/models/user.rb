class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  has_many :authorization_codes, inverse_of: :user, dependent: :delete_all

  validates :access_token,
    uniqueness: true

  before_validation :set_access_token,
    on: :create

  default_scope -> { where(deleted_at: nil) }

  class << self
    def authorize_with_token(token)
      where(access_token: token).first
    end
  end

  # Deleting user from database entirely is a bad practice, so please use this
  # method every time you need to destroy user.
  #
  # This will mark user as deleted, and default scope prevent user from showing
  # up in result sets.
  #
  def soft_destroy
    update_column(:deleted_at, Time.current)
  end

  private

  def set_access_token
    self.access_token = SecureRandom.hex(20)
  end
end
