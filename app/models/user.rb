class User < ApplicationRecord
  has_secure_password

  validates :name
  validates :email_confirmation, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  
end
