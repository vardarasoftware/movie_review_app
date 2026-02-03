class AddRatingIdToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :rating_id, :integer
  end
end
