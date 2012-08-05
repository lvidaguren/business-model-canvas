class AddNameToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :name, :string, default: 'Untitled Board'
  end
end
