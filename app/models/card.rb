class Card < ActiveRecord::Base
  attr_accessible :title, :content, :top, :left, :section, :board_id 
  belongs_to :board
end
