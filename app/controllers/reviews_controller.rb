class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie
  before_action :set_review, only: [:update, :destroy]
  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @movie = Movie.find(params[:movie_id])

    # one user → one review
    review = @movie.reviews.find_or_initialize_by(user: current_user)
    review.body = params[:review][:body]

    if review.save
      ReviewJob.perform_async(review.id, current_user.id)
      redirect_to @movie, notice: "Review submitted successfully"
    else
      redirect_to @movie, alert: "Unable to submit review"
    end
  end

  
  # def create
  #   @comment = Comment.new(comment_params)
  #   if @comment.save
  #     redirect_to @comment, notice: "Comment created successfully."
  #   else
  #     render :new
  #   end
  # end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to @review, notice: "Comment updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    redirect_back fallback_location: user_path(current_user), notice: "Comment deleted successfully"
  end


  # def destroy
  #   @review = Review.find(params[:id])
  #   @review.destroy
  #   redirect_to movies_path, notice: "Comment deleted successfully"
  # end
  
  private
  def review_path
    params.require(:review).permit(:title, :body)
  end

  def review_params
    params.require(:review).permit(:body, :user_id, :movie_id, :rating_id)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end
  
  def review_params
    params.require(:review).permit(:body)
  end
end
