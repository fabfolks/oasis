class ChangeEmailDefaultInMembersToNil < ActiveRecord::Migration
  def up
    change_column_default(:members, :email, nil)
  end

  def down
    change_column_default(:members, :email, "")
  end
end
