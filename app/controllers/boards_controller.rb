class BoardsController < ApplicationController
  after_filter :save_locale
  
  def show
    @cards = current_board.cards.group_by(&:section) || []
  end
  
  def section
    @section_name = params[:handler]
    @cards = current_board.cards.where("section = ?", @section_name)
  end
  
  def update
    current_board.update_attribute(params[:id], params[:value])
    render :text => params[:value]
  end
  
  protected
  def save_locale
    current_board.update_attribute(:locale, params[:locale]) if params[:locale] && params[:locale] != current_board.locale
    I18n.locale = params[:locale] || current_board.locale
  end
end
