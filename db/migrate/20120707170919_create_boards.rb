class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :key
      t.string :desgined_by
      t.string :designed_for

      t.timestamps
    end
  end
end
