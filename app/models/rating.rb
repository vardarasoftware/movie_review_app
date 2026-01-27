class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

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
