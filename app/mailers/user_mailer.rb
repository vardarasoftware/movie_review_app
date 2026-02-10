class UserMailer < ApplicationMailer
  default from: "notifications@example.com"

  def welcome_email
    @user = params[:user]
    #@url = "http://user.com/login"
    mail(to: @user.email, subject: "Your Most Welcome In Movie Review Application")
  end
end
