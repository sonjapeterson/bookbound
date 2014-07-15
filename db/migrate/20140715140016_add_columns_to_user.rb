class AddColumnsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :description, :text
  	add_column :users, :fav_books, :text
  	add_column :users, :fav_genres, :text
  	add_column :users, :fav_authors, :text
  end
end
