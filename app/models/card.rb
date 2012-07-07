class Card < ActiveRecord::Base
  attr_accessible :title, :content, :board_top, :board_left, :section_top, :section_left, :section, :board_id 
  belongs_to :board
end
