require 'base32/crockford'

class HomeController < ApplicationController
  def index
    board = Board.create
    board.update_attribute(:key, Base32::Crockford.encode(board.id))
    redirect_to board_path(board.key)
  end
  
  def save
    session[params[:id].to_sym] = params[:value] 
    render :text => RedCloth.new(params[:value]).to_html
  end
  
  def load
    render :text => session[params[:id].to_sym]
  end
  
end
