class Genre < ApplicationRecord
  has_many :movies, dependent: :destroy
  validates :name, presence: true
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
