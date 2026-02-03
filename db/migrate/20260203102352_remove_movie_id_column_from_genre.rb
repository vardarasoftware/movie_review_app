class RemoveMovieIdColumnFromGenre < ActiveRecord::Migration[7.1]
  def change
    remove_column :genres, :movie_id, :integer
  end
end
