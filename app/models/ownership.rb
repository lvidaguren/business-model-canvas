class Ownership < ActiveRecord::Base
  attr_accessible :board_id, :user_id
  
  belongs_to :user
  belongs_to :board
end
