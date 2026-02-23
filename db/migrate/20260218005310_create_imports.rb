class CreateImports < ActiveRecord::Migration[7.1]
  def change
    create_table :imports do |t|
      t.string :filename
      t.float :size
      t.integer :file_type
      t.integer :status
      t.integer :total_rows
      t.datetime :start_at
      t.datetime :finished_at
      t.json :meta

      t.timestamps
    end
  end
end
