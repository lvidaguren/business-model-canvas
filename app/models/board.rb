class Board < ActiveRecord::Base
  attr_accessible :designed_by, :designed_for
  has_many :cards
  belongs_to :user
  
  def public?
    !self.user
  end
  
  def private?
    !self.public?
  end
end
