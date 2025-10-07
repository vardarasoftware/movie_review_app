class CreateGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :genres do |t|
      t.string :name 
      t.references :movie, null: false, foreign_key: true
      t.timestamps
    end
    add_index :genres, :name, unique: true 
  end
end
