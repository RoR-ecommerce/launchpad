class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable

  has_many :authorizations, inverse_of: :user, dependent: :destroy
end
