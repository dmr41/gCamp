require 'rails_helper'
require 'spec_helper'

feature "comments" do
  scenario "test Bryans test" do
    log_user_in
  end

  scenario "tasks page has a comment button" do
    user = User.create!(first_name: "David", last_name: "Rivers", email: "d@d.com", password: "a", password_confirmation: "a")
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "d@d.com"
    fill_in "Password", with: "a"
    click_on "Sign in"
    click_on "Create project"
    fill_in "Name", with: "billy"
    click_on "Create Project"
    click_on "Create Task"
    fill_in "Description", with: "Task 1"
    fill_in "Date", with: Date.today
    click_on "Create Task"
    expect(page).to have_content("Task 1")
    expect(page).to have_content("Task was successfully created.")
    fill_in 'comment_description', with: "howdy"
    click_on "Add Comment"
  end

end
