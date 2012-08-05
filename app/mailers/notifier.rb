class Notifier < ActionMailer::Base
  default from: 'canvas.business.model@gmail.com'
  
  def to_comment(user, card, comment)  
    @user = user
    @card = card
    @comment = comment
    mail(to: @user.email, subject: "A new comment was added to #{@card.title}")  
  end 
end
