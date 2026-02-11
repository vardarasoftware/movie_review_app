class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :movies
  validates :name, presence: true
  def self.ransackable_attributes(auth_object = nil)
    [
      "id",
      "name",
      "email",
      "created_at",
      "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    [

    ]
  end
end
