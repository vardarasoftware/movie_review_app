class User < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :name, presence: true
end
