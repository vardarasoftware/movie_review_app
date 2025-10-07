class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
       
      t.integer :rating 
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true 
      
      t.timestamps
    end
  end
end
