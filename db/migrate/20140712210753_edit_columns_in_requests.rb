class EditColumnsInRequests < ActiveRecord::Migration
  def change
  	remove_column :requests, :requested  
  	remove_column :requests, :requester
  	remove_column :requests, :group
  	
  	add_column :requests, :requested_id, :integer
  	add_column :requests, :requester_id, :integer
  	add_column :requests, :group_id, :integer

  	add_index :requests, :requested_id
  	add_index :requests, :requester_id
  	add_index :requests, :group_id
  end

end
