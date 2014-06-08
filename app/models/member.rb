class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :sex, :contact_no, :role, :blood_group, :avatar, :delete_image
  belongs_to :house
  has_many :notifications, :dependent => :delete_all

  has_attached_file :avatar, :styles => { :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_size :avatar, :less_than => 1.megabytes
  validates_attachment_content_type :avatar, :content_type => /\Aimage/
  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpeg\Z/]
  validates :name, :presence => true
  before_validation {avatar.clear if @delete_image}

  self.per_page = 10

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

  def delete_image
    @delete_image ||= false
  end

  def delete_image=(value)
    @delete_image  = !value.to_i.zero?
  end
end
