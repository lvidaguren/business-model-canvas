class CardsController < ApplicationController
  def create
    card = Card.create(params[:card])
    card.update_attribute(:board, current_board)
    respond_to do |format|
      format.json { render json: {id: card.id, commentable: user_signed_in?} }
    end
  end

  def destroy
    card = Card.find(params[:id])
    card.destroy
    render text: ''
  end

  def update
    params[:id] =~ /(\d+)/
    card = Card.find($1)
    
    params[:id] =~ /card_(title|content)_(\d+)/
    if $1
      # For text editing
      card.update_attribute($1, params[:value])
      render text: params[:value]    
    else
      # For dragging
      card.update_attributes(params[:card])  
      render text: ''
    end
  end
end
