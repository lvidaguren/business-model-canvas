class ApplicationController < ActionController::Base
  protect_from_forgery
  
  prepend_before_filter :board_session_key  
  before_filter :set_locale
  before_filter :board_warning
  
  helper_method :current_board
  
  def after_sign_in_path_for(resource)
    resource.boards << current_board if current_board.public?
    super
  end
  
  def set_locale
    I18n.locale = params[:locale] || current_board.try(:locale) || I18n.default_locale
  end
  
  def default_url_options(options={})
    {:locale => I18n.locale}
  end
  
  def current_board
    p Board.find_by_key(session[:board_key]), 'ssssssssssssssssssssss', session[:board_key]
    @board ||= Board.find_by_key(session[:board_key])
  end
  
  def authenticate_user
    if current_board && current_board.private? && !current_board.users.include?(current_user)
      session[:board_key] = @previous_board_key
      flash[:error] = t('warning.private_board')
      redirect_to root_path 
    end
  end
  
  def board_warning
    current_board && current_board.public? && controller_name == 'boards' ? flash[:warning] = t('.warning.your_board_is_public') : flash.delete(:warning)
  end
  
  def board_session_key
    if params[:key] && !params[:key].blank?
      @previous_board_key = session[:board_key] # saving the old board key to use it if the board is restricted
      session[:board_key] = params[:key]
    end
  end
end
