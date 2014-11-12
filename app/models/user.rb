class User < ActiveRecord::Base

  # before_save {|user| user.email = user.email.downcase.strip}
  before_validation {|user| user.email = user.email.downcase.strip}


  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  has_secure_password

end
