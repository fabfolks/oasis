class AddHouseIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :house_id, :string

  end
end
