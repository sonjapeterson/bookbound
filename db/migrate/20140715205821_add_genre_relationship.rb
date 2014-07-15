class AddGenreRelationship < ActiveRecord::Migration
  def change
  	add_column :genres, :user_id, :integer
  end
end
