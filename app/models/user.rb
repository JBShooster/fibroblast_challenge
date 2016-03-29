class User < ActiveRecord::Base

  has_secure_password
  validates :username, :presence => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => create

  has_many :contacts, dependent: :destroy
end
