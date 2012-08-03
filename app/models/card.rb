class Card < ActiveRecord::Base
  attr_accessible :title, :content, :board_top, :board_left, :section_top, :section_left, :section, :board_id, :color
  belongs_to :board
  
  validates_inclusion_of :color, in: %w(purple green yellow red)
  
  COLORS = ['purple', 'green', 'yellow', 'red']
end
