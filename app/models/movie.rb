class Movie < ApplicationRecord
  has_many :user 
  has_many :comment 
  has_many :movie_genres 
  

  validate :name, presence: true 
  validate :description, presence: true 
  validate :release_date , presence: true 
  validate :directer , presence: true 
  validate :writer , presence: true 
  validate :actor , presence: true 
  validate :genre , presence: true 


  belongs_to :admin 
end
