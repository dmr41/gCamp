class Membership < ActiveRecord::Base

  validates  :user_id, presence: true, uniqueness: { scope: :project_id}
  belongs_to :user
  belongs_to :project

  # before_destroy :destroyable

  # def destroyable
  #   @project = Project.find(params[:project_id])
  #   total_owners = @project.memberships.where(role: "Owner")
  #   @owner_count = total_owners.count
  #   if @owner_count > 1 # This returns true when called via callback.
  #     true
  #   else
  #     false
  #   end
  # end

end
