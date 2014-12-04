namespace :orphans do

  desc "Count memberships and Comments without user_id values"
  task find: :environment do
    members = Membership.where.not(user_id: User.all).count
    comments = Comment.where.not(user_id: User.pluck(:id)).count
    puts "#{members} memberships without user_ids"
    puts "#{comments} comments without user_ids"
  end

  desc "Delete memberships and comments without user_id values"
  task delete: :environment do
    Membership.where.not(user_id: User.all).delete_all
    Comment.where.not(user_id: User.pluck(:id)).delete_all
  end

end
