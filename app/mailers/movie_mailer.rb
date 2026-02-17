class MovieMailer < ApplicationMailer
  default from: "movie@review.com"

  def new_movie_email
    @movie = params[:movie]
    mail(to: @movie.user.email, subject: "New Movie Added")
  end
  def movie_deleted_email(user, movie_title)
    @user = user
    @moives_title = movie_title
    mail(
      to: @user.email,
      subject: "Movie Deleted: #{@movie_title}"
    )
  end
end
