class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :name 
      t.string :description 
      t.integer :release_date 
      t.string :directer 
      t.string :writer 
      t.string :actor 
      
      t.timestamps
    end
  end
end
