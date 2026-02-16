class MovieDeletedEmailJob < ApplicationJob
 queue_as :default
  def perform(movie_title, user_id)
    user = User.find(user_id)
    MovieMailer.movie_deleted_email(user, movie_title).deliver_now
  end
end
