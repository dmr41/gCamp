require 'rails_helper'
require 'spec_helper'

feature "comments" do

  scenario "tasks page has a comment button" do
    project = Project.create!(name: "Billy")
    task = project.tasks.create!(description: "hi", date: Date.today)
    visit project_tasks_path(project)
    click_on "hi"
    fill_in "Comment", with: "stuff"
    click_on "Add Comment"
    expect(page).to have_content("user lastname")
    save_and_open_page
  end

end
