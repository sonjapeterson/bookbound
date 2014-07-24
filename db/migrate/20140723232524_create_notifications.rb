class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :read
      t.string :content

      t.timestamps
    end
  end
end
