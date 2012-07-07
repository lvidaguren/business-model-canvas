class BoardsController < ApplicationController
  def show
    @board = Board.find_by_key(params[:key])
    @cards = @board.cards.group_by(&:section) || []
  end
  
  def section
    @board = Board.find_by_key(params[:key])
    @section_name = params[:handler]
    @cards = @board.cards.where("section = ?", @section_name)
  end
end
