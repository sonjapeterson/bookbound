class ChangePagenumberToIntegerInNotes < ActiveRecord::Migration
  def change
  	change_column :notes, :pagenumber, 'integer USING CAST(pagenumber AS integer)'
  end
end
