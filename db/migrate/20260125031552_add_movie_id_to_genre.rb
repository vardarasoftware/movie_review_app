class AddMovieIdToGenre < ActiveRecord::Migration[7.1]
  def change
    add_column :genres, :movie_id, :integer
  end
end
