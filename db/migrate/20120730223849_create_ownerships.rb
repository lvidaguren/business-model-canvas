class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :user_id
      t.integer :board_id

      t.timestamps
    end
  end
end
