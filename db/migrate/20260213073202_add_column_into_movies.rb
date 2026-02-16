class AddColumnIntoMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :author, :string
    add_column :movies, :writer, :string
  end
end
