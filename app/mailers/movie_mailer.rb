class MovieMailer < ApplicationMailer
  default from: "notifications@example.com"

  def new_movie_email
    @movie = params[:movie]
    #@url = "http://user.com/login"
    mail(to: @movie.user.email, subject: "New Movie Added")
  end
end
