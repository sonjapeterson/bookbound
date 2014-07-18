class AddNewColumnsToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :publisher, :string
  	add_column :books, :pagecount, :integer
  	add_column :books, :imagelinklarge, :string
  	add_column :books, :imagelinksmall, :string
  	add_column :books, :datepublished, :string
  	add_column :books, :buylink, :string
  	add_column :books, :previewlink, :string
  end
end
