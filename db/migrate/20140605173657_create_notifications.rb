class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :member_id
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
