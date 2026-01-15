class Movie < ApplicationRecord
  has_one :rating, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true
end
