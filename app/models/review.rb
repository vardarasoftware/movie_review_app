class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true
  validates :user_id, uniqueness: { scope: :movie_id }
end
