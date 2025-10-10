class MoviesController < ApplicationController
    def index
        @movies = Movie
          .with_attached_banner
          .includes(:genres, :ratings)
          .order(created_at: :desc)
     end
  
    def show
      @movie = Movie.find(params[:id])
    end
end