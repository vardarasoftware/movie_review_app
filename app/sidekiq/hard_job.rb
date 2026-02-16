class HardJob
  include Sidekiq::Job

  def perform(movie)
    MovieMailer.movie_deleted_email(movie).deliver_now
  end
end
