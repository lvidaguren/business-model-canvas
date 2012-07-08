class AddLocaleColumnToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :locale, :string, :default => "en"
    
    Board.all.each{|board| board.update_attribute(:locale, "en")}
  end
end
