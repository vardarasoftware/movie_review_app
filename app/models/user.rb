class User < ApplicationRecord
  # REMOVE has_secure_password because Devise already handles passwords

  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Associations
  has_one_attached :avatar
  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :movies

  # Validations
  validates :name, presence: true

  # Call job after user creation
  after_create :send_welcome_email

  # OmniAuth login
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      user = User.create(
        name: data['name'],
        email: data['email'],
        password: Devise.friendly_token[0, 20],
        provider: access_token.provider,
        uid: access_token.uid
      )
    end

    user
  end

  # ActiveAdmin / Ransack configuration
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
    []
  end

  private

  def send_welcome_email
    SendWelcomeEmailJob.perform_later(self)
  end
end