class RemoveGenreIdFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :genre_id, :integer
  end
end
