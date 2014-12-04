class Membership < ActiveRecord::Base

  validates  :user_id, presence: true, uniqueness: { scope: :project_id}
  belongs_to :user
  belongs_to :project

end
