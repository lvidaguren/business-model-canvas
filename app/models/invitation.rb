class Invitation
  def self.to_board(invitee_email, inviter_email, board)
    board.users << unless user = User.find_by_email(invitee_email)
      user = User.invite!({email: invitee_email}, inviter_email)
      user.update_attribute(:invitation_board_key, board.key)
      user
    else
      Inviter.board_invitation(user, board).deliver
      user
    end
  end
end