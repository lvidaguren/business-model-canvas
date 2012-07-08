class BoardsController < ApplicationController
  after_filter :save_locale
  
  def show
    @cards = @board.cards.group_by(&:section) || []
  end
  
  def section
    @section_name = params[:handler]
    @cards = @board.cards.where("section = ?", @section_name)
  end
  
  def update
    @board.update_attribute(params[:id], params[:value])
    render :text => params[:value]
  end
  
  protected
  def save_locale
    @board.update_attribute(:locale, params[:locale]) if params[:locale] && params[:locale] != @board.locale
    I18n.locale = params[:locale] || @board.locale
  end
end
