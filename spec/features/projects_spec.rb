require 'rails_helper'

feature "projects" do

  scenario "Project name no input" do
    visit projects_path
    click_on "Create project"
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "Project created with counter links to tasks and Members" do
    visit projects_path
    expect(page).to have_no_content("The Big Dig")
    click_on "Create project"
    fill_in "Name", with: "The Big Dig"
    click_on "Create Project"
    expect(page).to have_content("The Big Dig")
    expect(page).to have_content("Project Created!")
    expect(page).to have_content("0 Tasks")
    expect(page).to have_content("0 Members")
  end

  scenario "Project created can be edited and destroyed" do
    visit projects_path
    expect(page).to have_no_content("The Big Dig")
    click_on "Create project"
    fill_in "Name", with: "The Big Dig"
    click_on "Create Project"
    expect(page).to have_content("The Big Dig")
    click_on "Edit"
    fill_in "Name", with: "The Little Dig"
    click_on "Update Project"
    expect(page).to have_no_content("The Big Dig")
    expect(page).to have_content("The Little Dig")
    expect(page).to have_content("Project Updated!")
    click_on "Destroy"
    expect(page).to have_content("Project has been destroyed forever!")
  end



end
