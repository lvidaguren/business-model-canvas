require 'base32/crockford'

class HomeController < ApplicationController
  def index
    board = Board.create
    board.update_attribute(:key, Base32::Crockford.encode(board.id))
    redirect_to board_path(board.key)
  end
end
