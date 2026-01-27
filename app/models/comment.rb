class Comment < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  # REQUIRED FOR ACTIVEADMIN / RANSACK
  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "body",
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
