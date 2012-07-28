require 'base32/crockford'

class HomeController < ApplicationController
  def index
    board = Board.find_by_key(session[:board_key]) || Board.create
    board.update_attribute(:key, Base32::Crockford.encode(board.id))
    session[:board_key] = board.key
    redirect_to board_path(board.key)
  end
end
