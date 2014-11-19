class Membership < ActiveRecord::Base

  validates  :user_id, presence: true, uniqueness: true
  belongs_to :user
  belongs_to :project

end
