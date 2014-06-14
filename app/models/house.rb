class House < ActiveRecord::Base
  has_many :members
  validates :name, :uniqueness => true
end
