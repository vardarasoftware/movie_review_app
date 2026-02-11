class Movie < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_one_attached :avatar

  after_create_commit :notify_new_movie


  def average_rating
    ratings.average(:rating)&.round(1)
  end

  scope :with_min_rating, ->(min = nil) {
    return all if min.blank?

    joins(:ratings)
      .group("movies.id")
      .having("AVG(ratings.rating) >= ?", min.to_f)
  }

  def self.ransackable_scopes(_auth_object = nil)
    [:with_min_rating]
  end

  #REQUIRED FOR ACTIVEADMIN / RANSACK
  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "title",
      "description",
      "genre_id",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "reviews",
      "ratings",
      "genre"
    ]
  end
  private
  def notify_new_movie
    MovieMailer.with(movie: self).new_movie_email.deliver_later
  end
end


# class Movie < ApplicationRecord
#   has_one_attached :avatar do |attachable|
#     attachable.variant :thumb, resize_to_limit: [100, 100]
#   end
#   has_one :rating, dependent: :destroy
#   has_many :comments, dependent: :destroy
#   validates :title, presence: true
# end
