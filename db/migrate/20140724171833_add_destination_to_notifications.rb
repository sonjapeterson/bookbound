class AddDestinationToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :destination, :string
  end
end
