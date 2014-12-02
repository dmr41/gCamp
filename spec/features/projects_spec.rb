require 'rails_helper'

feature "projects" do

  scenario "Project name no input" do
    user = User.create!(first_name: "David", last_name: "Rivers", email: "d@d.com", password: "a", password_confirmation: "a")
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "d@d.com"
    fill_in "Password", with: "a"
    click_on "Sign in"
    click_on "Create project"
    click_on "Create Project"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "Project created with counter links to tasks and Members" do
    user = User.create!(first_name: "David", last_name: "Rivers", email: "d@d.com", password: "a", password_confirmation: "a")
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "d@d.com"
    fill_in "Password", with: "a"
    click_on "Sign in"
    expect(page).to have_no_content("The Big Dig")
    click_on "Create project"
    fill_in "Name", with: "The Big Dig"
    click_on "Create Project"
    expect(page).to have_content("The Big Dig")
    expect(page).to have_content("Project Created!")
    find('ol li a', text: 'The Big Dig').click
    expect(page).to have_content("0 Tasks")
    expect(page).to have_content("1 Member")
  end

  scenario "Project created can be edited and destroyed" do
    user = User.create!(first_name: "David", last_name: "Rivers", email: "d@d.com", password: "a", password_confirmation: "a")
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "d@d.com"
    fill_in "Password", with: "a"
    click_on "Sign in"
    expect(page).to have_no_content("The Big Dig")
    click_on "Create project"
    fill_in "Name", with: "The Big Dig"
    click_on "Create Project"
    find('ol li a', text: 'The Big Dig').click
    expect(page).to have_content("The Big Dig")
    click_on "Edit"
    fill_in "Name", with: "The Little Dig"
    click_on "Update Project"
    expect(page).to have_no_content("The Big Dig")
    expect(page).to have_content("The Little Dig")
    expect(page).to have_content("Project Updated!")
    click_on "Delete"
    expect(page).to have_content("Project has been destroyed!")
  end



end
