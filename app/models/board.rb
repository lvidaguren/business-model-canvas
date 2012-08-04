class Board < ActiveRecord::Base
  attr_accessible :designed_by, :designed_for
  has_many :cards
  
  has_many :ownerships
  has_many :users, through: :ownerships
  
  def public?
    self.users.blank?
  end
  
  def private?
    !self.public?
  end
  
  def to_param
    self.key
  end
end
