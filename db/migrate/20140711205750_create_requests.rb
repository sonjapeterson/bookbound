class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requester
      t.integer :requested
      t.integer :group
      t.boolean :status

      t.timestamps
    end
  end
end
