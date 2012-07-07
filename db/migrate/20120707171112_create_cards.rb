class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :content
      t.string :title
      t.string :left
      t.string :top
      t.string :section
      t.integer :board_id

      t.timestamps
    end
  end
end
