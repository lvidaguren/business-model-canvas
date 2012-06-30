class HomeController < ApplicationController
  def index
  end
  
  def save
    session[params[:id].to_sym] = params[:value] 
    render :text => RedCloth.new(params[:value]).to_html
  end
  
  def load
    render :text => session[params[:id].to_sym]
  end
end
