class ChangePagenumberToIntegerInNotes < ActiveRecord::Migration
  def change
  	change_column :notes, :pagenumber, :integer
  end
end
