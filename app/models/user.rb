class User < ApplicationRecord
  has_secure_token :api_key
  has_secure_password

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :api_key, uniqueness: true
end
