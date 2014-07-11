class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.belongs_to :group
      t.string :pagenumber
      t.text :body
      t.timestamps
    end
  end
end
