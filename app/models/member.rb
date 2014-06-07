class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :sex, :contact_no, :role, :blood_group
  belongs_to :house
  has_many :notifications
  validates :name, :presence => true

  def is_admin?
    self.role == 'admin'
  end

  def is_member_of?(house)
    self.house.name == house.name
  end

  def can_edit?(member)
    return true if self.id == member.id
    return true if self.is_admin? and member.is_member_of?(self.house)
    false
  end
end
