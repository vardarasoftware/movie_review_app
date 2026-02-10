class RatingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @ratings = Rating.all
  end

  def show
    @rating = Rating.find(params[:id])
  end

  def new
    @rating = Rating.new
  end

  def create
  @movie = Movie.find(params[:movie_id])

  rating = @movie.ratings.find_or_initialize_by(user: current_user)
  rating.rating = params[:rating][:rating]

    if rating.save
      redirect_to @movie, notice: "Rating saved"
    else
      redirect_to @movie, alert: "Invalid rating"
    end
  end
  
  # def create
  #   @rating = Rating.new(rating_params)
  #   if @rating.save
  #     redirect_to @rating, notice: "Rating created successfully."
  #   else
  #     render :new
  #   end
  #end

  def edit
    @rating = Rating.find(params[:id])
  end

  def update
    @rating = Rating.find(params[:id])
    if @rating.update(rating_params)
      redirect_to @rating, notice: "Rating updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy
    redirect_back fallback_location: user_path(current_user), notice: "Rating deleted successfully"

    #redirect_to ratings_path, notice: "Rating deleted successfully"
  end
  
  private
  def rating_path
    params.require(:rating).permit(:title, :body)
  end

  def rating_params
    params.require(:rating).permit(:rating, :user_id, :movie_id)
  end
end
