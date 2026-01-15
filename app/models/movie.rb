class Movie < ApplicationRecord
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_one :rating, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true
end
