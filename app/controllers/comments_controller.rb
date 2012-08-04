class CommentsController < ApplicationController
  def index
    @card = current_board.cards.find(params[:id])
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
end
