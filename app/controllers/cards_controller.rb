class CardsController < ApplicationController
  def create
    card = Card.create(params[:card])
    respond_to do |format|
      format.json { render json: card.id }
    end
  end

  def destroy
    card = Card.find(params[:id])
    card.destroy
    render :text => ""
  end

  def update
    params[:id] =~ /(\d+)/
    card = Card.find($1)
    
    params[:id] =~ /card_(title|content)_(\d+)/
    if $1
      card.update_attribute($1, params[:value])
      render :text => params[:value]    
    else
      card.update_attributes(params[:card])  
    end
  end
end
