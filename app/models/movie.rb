class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :rating, dependent: :destroy
  has_one_attached :avatar

  # REQUIRED FOR ACTIVEADMIN / RANSACK
  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "title",
      "discription",
      "genre_id",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [
      "comments",
      "rating"
    ]
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
