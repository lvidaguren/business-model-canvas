class CommentsController < ApplicationController
  before_filter :load_card
  
  def index
    @comments = @card.comment_threads.order(:created_at)
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.commentable = @card
    @comment.user = current_user
    @comment.save!
    
    @comments = @card.comment_threads.order(:created_at)
  end
  
  def destroy
    comment = @card.comment_threads.find(params[:id])
    comment.destroy
    
    @comments = @card.comment_threads.order(:created_at)
  end
  
  protected
  def load_card
    @card = current_board.cards.find(params[:card_id])
  end
end
