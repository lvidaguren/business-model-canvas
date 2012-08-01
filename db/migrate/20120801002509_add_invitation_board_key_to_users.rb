class AddInvitationBoardKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invitation_board_key, :string
  end
end
