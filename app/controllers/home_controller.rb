require 'base32/crockford'

class HomeController < ApplicationController
  def index
    board = user_signed_in? ? current_user.boards.find_by_key(session[:board_key]) : current_board || Board.create
    board.update_attribute(:key, Base32::Crockford.encode(board.id)) unless board.key
    session[:board_key] = board.key
    
    flash_key = flash.keys.first.try(:to_sym)
    flash_message = flash_key ? {flash: {flash_key => flash[flash_key]}} : {}
    redirect_to board_path(board.key), flash_message
  end
end
