require 'rails_helper'

feature "memberships" do


  scenario "create a membership and delete it" do
    # @project = Project.create!(name: "Biggy")
    @user = User.create!(first_name: "Day", last_name:"Night",
    email: "day@night.com", password: "sun",
    password_confirmation: "sun")
    visit sign_in_path
    fill_in "Email", with: "day@night.com"
    fill_in "Password", with: "sun"
    click_on "Sign in"
    click_on "Create project"
    fill_in "Name", with: "Biggy"
    click_on "Create Project"
    expect(page).to have_content("Project Created!")
    visit projects_path
    find('tr a', text: 'Biggy').click
    click_on "Member"
    select("Day Night", from: "membership_user_id")
    click_on "Add New Member"
    expect(page).to have_content("User has already been taken")
    # find('td/a.glyphicon').click
    # find("td/a.glyphicon").click
  end

end
