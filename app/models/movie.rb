class Movie < ApplicationRecord

    has_one_attached :banner
    belongs_to :admin
    has_many :ratings, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :movie_genres, dependent: :destroy
    has_many :genres, through: :movie_genres

    validates :title, presence: true
    validates :description, presence: true
    validates :release_date, presence: true
    validates :director, presence: true
    validates :writer, presence: true

end
