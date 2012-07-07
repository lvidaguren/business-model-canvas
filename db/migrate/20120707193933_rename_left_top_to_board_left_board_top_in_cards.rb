class RenameLeftTopToBoardLeftBoardTopInCards < ActiveRecord::Migration
  def up
    rename_column :cards, :top, :board_top
    rename_column :cards, :left, :board_left
  end

  def down
    rename_column :cards, :board_top, :top
    rename_column :cards, :board_left, :left
  end
end
