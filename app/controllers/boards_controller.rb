class BoardsController < ApplicationController
  after_filter :save_locale
  before_filter :authenticate_user
  
  def index
    @boards = current_user.boards  
  end
  
  def show
    @cards = current_board.cards.group_by(&:section) || []
  end
  
  def section
    @section_name = params[:handler]
    @cards = current_board.cards.where("section = ?", @section_name)
  end
  
  def update
    current_board.update_attribute(params[:attribute], params[:value])
    render :text => params[:value]
  end
  
  def new
    board = Board.create
    board.update_attribute(:key, Base32::Crockford.encode(board.id))
    current_user.boards << board if user_signed_in?
    session[:board_key] = board.key
    
    redirect_to board_path(board.key), notice: t('boards.new.board_created')
  end
  
  protected
  def save_locale
    current_board.update_attribute(:locale, params[:locale]) if params[:locale] && params[:locale] != current_board.locale
    I18n.locale = params[:locale] || current_board.locale
  end
end
