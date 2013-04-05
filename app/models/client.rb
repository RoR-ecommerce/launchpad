class Client < ActiveRecord::Base
  validates :name, :app_id, :app_secret, :uri, :redirect_uri,
    presence: true

  validates :app_id, :app_secret, :uri, :redirect_uri,
    uniqueness: true

  before_validation :set_app_id, :set_app_secret,
    on: :create

  class << self
    def authorize!(app_id)
      where(app_id: app_id).first!
    end
  end

  private

  def set_app_id
    self.app_id = SecureRandom.hex(10)
  end

  def set_app_secret
    self.app_secret = SecureRandom.hex(20)
  end
end
