class InvitationsController < ApplicationController
  before_filter :authenticate_user
  
  def invite
    params[:emails].split(/[\s;]+/).each do |email|
      user = User.invite!({email: email}, current_user)
      current_board.users << user # Adding the invited user to the current board collaborators
    end
    
    redirect_to board_path(current_board.key), notice: t('devise.invitations.send_instructions')
  end
end
