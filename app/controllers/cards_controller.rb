class CardsController < ApplicationController
  def create
    card = Card.create(params[:card])
    respond_to do |format|
      format.json { render json: card.id }
    end
  end

  def destroy
  end

  def edit
  end

  def update
    card = Card.find(params[:id])
    card.update_attributes(params[:card])
  end
end
