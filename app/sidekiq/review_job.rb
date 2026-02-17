class ReviewJob
  include Sidekiq::Job

  def perform(review_id, user_id)
    review = Review.find(review_id)
    user = User.find(user_id)

    ReviewMailer.review_notification(user, review).deliver_now
  end
end
