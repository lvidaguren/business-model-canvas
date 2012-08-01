class Inviter < ActionMailer::Base
  default from: 'canvas.business.model@gmail.com'
  
  def board_invitation(user, board)  
    @board = board
    @user = user
    mail(to: user.email, subject: 'Invitation to a board on Business Model Canvas')  
  end  
end
