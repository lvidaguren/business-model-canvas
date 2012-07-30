class InvitationsController < ApplicationController
  before_filter :authenticate_user
  
  def invite
    params[:emails].split(/[\s;]+/).each do |email|
      User.invite!({email: email}, current_user)
    end
    
    redirect_to board_path(current_board), notice: t('devise.invitations.send_instructions')
  end
end
