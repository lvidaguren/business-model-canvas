class RenameDesgniedByToDesignedByInBoards < ActiveRecord::Migration
  def up
    rename_column :boards, :desgined_by, :designed_by
  end

  def down
    rename_column :boards, :designed_by, :desgined_by
  end
end
