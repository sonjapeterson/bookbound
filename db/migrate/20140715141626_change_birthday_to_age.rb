class ChangeBirthdayToAge < ActiveRecord::Migration
  def change
  	add_column :users, :age, :integer
  	remove_column :users, :birthday
  end
end
