class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie

  def create
    @rating = @movie.ratings.find_or_initialize_by(user: current_user)
    @rating.assign_attributes(rating_params)
    if @rating.save
      redirect_to @movie, notice: "Rating saved."
    else
      redirect_to @movie, alert: @rating.errors.full_messages.to_sentence
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def rating_params
    params.require(:rating).permit(:rating)
  end
end
