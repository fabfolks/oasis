class Notification < ActiveRecord::Base
  belongs_to :member
  self.per_page = 2
end
