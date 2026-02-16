class RemoveRatingidFromMovies < ActiveRecord::Migration[7.1]
  def change
    remove_column :movies, :rating_id, :integer
  end
end
