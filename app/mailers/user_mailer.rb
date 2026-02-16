class UserMailer < ApplicationMailer
  default from: "movie@review.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Your Most Welcome In Movie Review Application")
  end
end
