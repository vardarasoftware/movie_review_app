class Movie < ApplicationRecord

    has_one_attached :banner
    has_many :ratings, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :movie_genres, dependent: :destroy
    has_many :genres, through: :movie_genres

    validates :title, presence: true
    validates :description, presence: true
    validates :release_date, presence: true
    validates :director, presence: true
    validates :writer, presence: true

    def update_rating_stats
        if ratings.any?
          self.average_rating = ratings.average(:rating).round(1)
          self.ratings_count = ratings.count
        else
          self.average_rating = nil
          self.ratings_count = 0
        end
        save!
    end

end
