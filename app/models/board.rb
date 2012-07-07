class Board < ActiveRecord::Base
  attr_accessible :designed_by, :designed_for
  has_many :cards
end
