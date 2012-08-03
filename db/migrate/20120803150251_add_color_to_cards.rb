class AddColorToCards < ActiveRecord::Migration
  def change
    add_column :cards, :color, :string, :default => 'yellow'
  end
end
