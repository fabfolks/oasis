class AddWeddingAnniversaryToMembers < ActiveRecord::Migration
  def change
    add_column :members, :wedding_anniversary, :date
  end
end
