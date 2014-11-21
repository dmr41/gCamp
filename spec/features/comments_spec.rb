require 'rails_helper'
require 'spec_helper'

feature "comments" do

  scenario "tasks page has a comment button" do
    user = User.create!(first_name: "David", last_name: "Rivers", email: "d@d.com", password: "a", password_confirmation: "a")
    project = Project.create!(name: "Billy")
    task = project.tasks.create!(description: "Task 1", date: Date.today)
    visit project_tasks_path(project)
    click_on "Task 1"
    fill_in "Description", with: "howdy"
    click_on "Create Comment"
    expect(page).to have_content("howdy")
  end

end
