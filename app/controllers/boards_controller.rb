class BoardsController < ApplicationController
  after_filter :save_locale
  before_filter :authenticate_user
  AVAILABLE_FORMATS = ['png', 'jpg', 'pdf']
  
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
  
  def download
    @section_name = params[:section_name] # section name
    # Fetch the card of the board/section
    @cards = @section_name ? current_board.cards.where('section = ?', @section_name) : current_board.cards.group_by(&:section) || []
    
    kit = IMGKit.new(render_to_string("#{params[:file]}.other.html.haml", layout: false), width: 1200, height: 1100)
    kit.stylesheets << 'public/stylesheets/save.css'
    
    board, type = case params[:type]
      when 'png'
        [kit.to_png, 'image/png']
      when 'jpg'
        [kit.to_jpg, 'image/jpg']
      when 'pdf'
        [kit.to_jpg, 'application/pdf']
    end 
    
    if AVAILABLE_FORMATS.include?(params[:type])
      send_data(board, type: type, filename: "#{current_board.name}.#{params[:type]}")
    else
      redirect_to board_path(current_board), notice: t('.not_valid_format')
    end
  end
  
  protected
  def save_locale
    current_board.update_attribute(:locale, params[:locale]) if params[:locale] && params[:locale] != current_board.locale
    I18n.locale = params[:locale] || current_board.locale
  end
end
