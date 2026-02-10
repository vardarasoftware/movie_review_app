class RenameDiscriptionToDescriptionFromMovies < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :discription, :description
  end
end
