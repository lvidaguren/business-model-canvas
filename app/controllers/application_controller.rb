class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale, :authenticate_user
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
    @board ||= Board.find_by_key(session[:board_key])
  end
  
  def authenticate_user
    if current_board && current_board.private? && current_board.user != current_user
      flash[:notice] = t('.private_board')
      redirect_to root_path  
    end
  end
end
