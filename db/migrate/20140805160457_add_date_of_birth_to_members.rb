class AddDateOfBirthToMembers < ActiveRecord::Migration
  def change
    add_column :members, :date_of_birth, :date
  end
end
