class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :rating, presence: true, inclusion: { in: 1..5 }

  after_save :update_movie_rating_stats
  after_destroy :update_movie_rating_stats

  private

  def update_movie_rating_stats
    movie.update_rating_stats
  end
end
