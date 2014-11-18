require 'rails_helper'

feature "projects" do

  scenario "Project name no input" do
    visit projects_path
    click_on "Create project"
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")
  end

end
