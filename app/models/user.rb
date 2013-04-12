class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable

  has_many :authorization_codes, inverse_of: :user, dependent: :delete_all

  # Since validatable module has to be disabled in order to remove password
  # confirmation from sign up screen, almost all device validation are moved
  # here. Please check devise source code for more information
  # https://github.com/plataformatec/devise/blob/master/lib/devise/models/validatable.rb

  validates :full_name, :access_token, :uid,
    presence: true

  validates :email,
    presence:   true,
    format:     { with: /\A[^@]+@[^@]+\z/, allow_blank: true, if: :email_changed? },
    uniqueness: { case_sensitive: false, allow_blank: true, if: :email_changed? }

  validates :access_token, :uid,
    uniqueness: true

  validates :password,
    presence: { if: :password_required? },
    length:   { minimum: 6, maximum: 128, allow_blank: true }

  validates :password,
    confirmation: { on: :update, if: :password_required? }

  before_validation :set_access_token, :set_uid,
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

  def as_json(options = nil)
    super({
      only: [ :uid, :email, :created_at, :updated_at]
    }.merge(options || {}))
  end

  private

  def set_access_token
    self.access_token = SecureRandom.hex(20)
  end

  def set_uid
    self.uid = SecureRandom.uuid
  end

  # Checks whether a password is needed or not. For validations only.
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere.
  #
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
