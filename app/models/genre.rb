class Genre < ApplicationRecord
    validates :name, presence: true
    
    has_many :movie_genres 

end
