class User < ActiveRecord::Base

  # before_save {|user| user.email = user.email.downcase.strip}
  before_validation {|user| user.email = user.email.downcase.strip}

  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments, dependent: :nullify

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end

end
