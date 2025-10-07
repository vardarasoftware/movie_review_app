class Genre < ApplicationRecord
    validates :name, presence: true
    
    has_many :movies, dependent: :destroy

end
