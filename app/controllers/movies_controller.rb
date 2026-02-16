class MoviesController < ApplicationController
    before_action :authenticate_user!

  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true)
                .includes(:ratings, :genre)
                .page(params[:page])
     @pagy, @movies = pagy(:offset, @movies, limit: 5)
  end

  def show
    @movie = Movie.find(params[:id])
    @rating = current_user&.ratings&.find_by(movie: @movie) || Rating.new
    @review = current_user&.reviews&.find_by(movie: @movie) || Review.new
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.new(movie_params)

    respond_to do |format|
      if @movie.save
        MovieMailer.with(movie: @movie).new_movie_email.deliver_later
      end
    end
  end

  # def create
  #   @movie = Movie.new(movie_params)
  #   if @movie.save
  #     redirect_to @movie, notice: "Movie created successfully."
  #   else
  #     render :new
  #   end
  # end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    movie_title = @movie.title
    user_id     = current_user.id
    @movie.destroy
    MovieDeletedEmailJob.perform_later(movie_title, user_id)
    redirect_to movie_path, notice: "Movie deleted successfully"
  end

  private
  def movie_path
    params.require(:moive).permit(:title, :body)
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :genre_id, :avatar, :author, :writer)
  end

end
