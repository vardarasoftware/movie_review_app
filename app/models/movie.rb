class Movie < ApplicationRecord
  has_many :user 
  has_many :comment 
  belongs_to :genre 
  

  validate :name, presence: true 
  validate :description, presence: true 
  validate :release_date , presence: true 
  validate :directer , presence: true 
  validate :writer , presence: true 
  validate :actor , presence: true 
  validate :genre , presence: true 


  belongs_to :admin 
end
