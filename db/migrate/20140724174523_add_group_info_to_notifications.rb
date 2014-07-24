class AddGroupInfoToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :group, :integer
  end
end
