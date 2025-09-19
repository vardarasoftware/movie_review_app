class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.date :release_date
      t.string :director
      t.string :writer
      t.string :banner_url
      t.float :average_rating
      t.integer :ratings_count

      t.timestamps
    end
  end
end
