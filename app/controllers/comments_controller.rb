class CommentsController < ApplicationController
  def index
    @card = current_board.cards.find(params[:card_id])
    @comments = @card.comment_threads
  end
  
  def create
    @card = current_board.cards.find(params[:comment][:commentable_id])
    @comment = Comment.new(params[:comment])
    @comment.commentable = @card
    @comment.user = current_user
    @comment.save!
    
    @comments = @card.comment_threads
  end
  
  def destroy
    @card = current_board.cards.find(params[:card_id])
    comment = @card.comment_threads.find(params[:id])
    comment.destroy
    
    @comments = @card.comment_threads
  end
end
