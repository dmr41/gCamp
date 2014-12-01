namespace :orphans do

  desc "Delete memberships without user_id values"
  task find: :environment do
    absent_membership_users = Membership.where(user_id: nil).count
    absent_membership_projects = Membership.where(project_id: nil).count
    absent_task_comments = Comment.where(task_id: nil).count

    puts "#{absent_membership_users} memberships without a user_id"
    puts "#{absent_membership_projects} memberships without a project_id"
    puts "#{absent_task_comments} comments that have no task_id"
  end

  desc "Delete memberships without user_id values"
  task delete: :environment do
    absent_membership_users = Membership.where(user_id: nil).delete_all
    absent_membership_projects = Membership.where(project_id: nil).delete_all
    absent_task_comments = Comment.where(task_id: nil).delete_all
  end

end
