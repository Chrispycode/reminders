class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password
  validates_presence_of :password_confirmation, on: :create
end
