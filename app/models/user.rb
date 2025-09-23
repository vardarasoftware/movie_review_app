class User < ApplicationRecord

    has_secure_password
    has_many :ratings, dependent: :destroy
    has_many :comments, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, allow_nil: true
end
