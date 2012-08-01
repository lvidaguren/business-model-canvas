class InvitationsController < ApplicationController
  before_filter :authenticate_user
  
  def invite
    params[:emails].split(/[\s;]+/).each do |invitee_email|
      Invitation.to_board(invitee_email, current_user, current_board)
    end
    
    redirect_to board_path(current_board.key), notice: t('devise.invitations.send_instructions')
  end
end
