class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :user_id, uniqueness: { scope: :movie_id }

  def self.ransackable_attributes(auth_object = nil)
    %w[rating]
  end

  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "rating",
      "movie_id",
      "user_id",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "movie",
      "user"
    ]
  end
end
