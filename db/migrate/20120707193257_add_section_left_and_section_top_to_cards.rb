class AddSectionLeftAndSectionTopToCards < ActiveRecord::Migration
  def change
    add_column :cards, :section_left, :string
    add_column :cards, :section_top, :string
  end
end
