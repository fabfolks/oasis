class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :sex
      t.string :contact_no
      t.string :role
      t.string :blood_group

      t.timestamps
    end
  end
end
