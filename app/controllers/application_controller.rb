class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :board, :set_locale
  
  def board
    if params[:key]
      @board = Board.find_by_key(params[:key])
    elsif params[:board_id]
      @board = Board.find(params[:board_id])
    end
  end
  
  def set_locale
    I18n.locale = params[:locale] || @board.try(:locale) || I18n.default_locale
  end
  
  def default_url_options(options={})
    {:locale => I18n.locale}
  end
end
