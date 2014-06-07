class Notification < ActiveRecord::Base
  belongs_to :member
  validates :title, :presence => true
  validates :content, :presence => true
  self.per_page = 2
end
