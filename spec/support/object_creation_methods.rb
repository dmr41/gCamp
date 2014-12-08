
def create_project
  Project.create!(name: "#{Faker::Hacker.ingverb.humanize} #{Faker::Hacker.noun.humanize}")
end

def create_task(options = {})
  project = options[:project] || create_project
  Task.create!(description: Faker::Lorem.sentence,
  date: Faker::Time.forward(24),
  complete: false,
  project_id: project.id,)
end


def create_user
  User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: Faker::Internet.password,)
end

def create_super_user
  User.create!(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  password: Faker::Internet.password,
  admin: true)
end

def create_membership(options = {})
  project = options[:project] || create_project
  user = options[:user] || create_user
  Membership.create!(
  role: "Member",
  project_id: project.id,
  user_id: user.id,)
end

def create_ownership(options = {})
  project = options[:project] || create_project
  user = options[:user] || create_user
  Membership.create!(
  role: "Owner",
  project_id: project.id,
  user_id: user.id,)
end

def log_user_in(options = {})
  user = options[:user] || create_user
  visit root_path
  click_on "Sign In"
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_on "Sign in"
end
