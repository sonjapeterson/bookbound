class CreateContactForms < ActiveRecord::Migration
  def change
    create_table :contact_forms do |t|
      t.string :name
      t.string :toemail
      t.string :fromemail
      t.text :message
      t.timestamps
    end
  end
end
