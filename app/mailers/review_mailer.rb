class ReviewMailer < ApplicationMailer
  default from: "support@moviereview.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.review_mailer.review_notification.subject
  #
  def review_notification(user, review)
    @user = user
    @review = review
    @movie = @review.movie

    mail(
      to: @user.email,
      subject: "Thanks for review #{@movie.title}!"
    )
  end
end
