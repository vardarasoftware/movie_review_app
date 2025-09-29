class User < ApplicationRecord

    has_secure_password
    has_many :ratings, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 8 }, 
              format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]/, 
                        message: "must contain at least one lowercase letter, one uppercase letter, one digit, and one special character" },
              allow_nil: true
    validates :password_confirmation, presence: true, on: :create
end