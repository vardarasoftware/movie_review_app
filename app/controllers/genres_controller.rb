class GenresController < ApplicationController
  def index
    @genre = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: "Genre created successfully."
    else
      render :new
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to @genre, notice: "Genre updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to genre_path, notice: "Genre deleted successfully"
  end

  private
  def genre_path
    params.require(:genre).permit(:title, :body)
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

end
