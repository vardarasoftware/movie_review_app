class AdminsController < ApplicationController
  before_action :authenticate_user!
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(admin_params)
    if @movie.save
      redirect_to @movie, notice: "movie created successfully."
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(admin_params)
      redirect_to @movie, notice: "movie updated successfully."
    else
      render :edit
    end
  end


  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to admins_path, notice: "movie deleted successfully."
  end

  private
  def admin_params
    params.require(:movie).permit(:title, :discription)
  end

  def admin_path
    params.require(:movie).permit(:avatar, :title, :discription, :genre_id)
  end
end

