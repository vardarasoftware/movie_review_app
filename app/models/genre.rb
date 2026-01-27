class Genre < ApplicationRecord
  belongs_to :movie
  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "movie_id",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "movie",
    ]
  end
end
