class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.integer :classic
      t.integer :comedy
      t.integer :comic
      t.integer :educational
      t.integer :historical
      t.integer :memoir
      t.integer :mystery
      t.integer :nonfiction
      t.integer :poetry
      t.integer :pulp
      t.integer :romance
      t.integer :scifi
      t.integer :shortstory
      t.timestamps
    end
  end
end
