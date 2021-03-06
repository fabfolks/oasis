class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :name, :sex, :contact_no,
    :role, :blood_group, :avatar, :delete_image, :login, :house_id, :date_of_birth, :wedding_anniversary
  attr_accessor :login
  belongs_to :house
  has_many :notifications, :dependent => :delete_all
  before_validation {avatar.clear if @delete_image}

  has_attached_file :avatar, :styles => { :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
    :url => "/assets/images/members/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/images/members/:id/:style/:basename.:extension"
  validates_attachment_size :avatar, :less_than => 1.megabytes, :message => 'size should be <= 1MB'
  validates_attachment_content_type :avatar, :content_type => /\Aimage/, :message => 'Please upload an image file'
  validates_attachment_file_name :avatar, :matches => [/png|PNG\Z/, /jpeg|JPEG\Z/, /jpg|JPG\Z/], :message => 'valid extensions are png, jpg and jpeg'
  validates :house_id, :presence => true, :on => :create
  validates :role, :presence => true
  validates :name, :presence => true
  validates :username, :uniqueness => { :case_sensitive => false }
  validates :email, :uniqueness => {:case_sensitive => false}, :format => {:with  => Devise.email_regexp}, :allow_nil => true
  validates :password, :confirmation => true, :length => {:within => Devise.password_length}, :allow_nil => true

  self.per_page = 10

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

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

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
end
