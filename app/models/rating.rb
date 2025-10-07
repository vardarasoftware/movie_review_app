class Rating < ApplicationRecord
  validates :rating, presence: true 

  belongs_to :users, :movies
end
