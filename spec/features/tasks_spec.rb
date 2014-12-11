require 'rails_helper'
require 'spec_helper'

feature "signup" do

  scenario "checks tasks for task creation show and edit" do
    @user = User.create!(first_name: "Day", last_name:"Night",
    email: "day@night.com", password: "sun",
    password_confirmation: "sun")
    visit sign_in_path
    fill_in "Email", with: "day@night.com"
    fill_in "Password", with: "sun"
    click_on "Sign in"
    click_on "New project"
    fill_in "Name", with: "Biggy"
    click_on "Create Project"
    click_on "Create Task"
    fill_in "Description", with: "David"
    fill_in "Date", with: "12/12/2020"
    click_on "Create Task"
    expect(page).to have_content("David")
    expect(page).to have_content("12/12/2020")
    expect(page).to have_content("Task was successfully created.")
    click_on "Edit"
    fill_in "Description", with: "Billy"
    fill_in "Date", with: "11/11/2020"
    check('Complete')
    click_on "Update Task"
    expect(page).to have_no_content("Task was successfully created.")
    expect(page).to have_content("Billy")
    expect(page).to have_no_content("11/11/2022")
    expect(page).to have_content("Task was successfully updated.")
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("12/12/2020")
  end

  scenario "checks tasks for task destroy" do
    @user = User.create!(first_name: "Day", last_name:"Night",
    email: "day@night.com", password: "sun",
    password_confirmation: "sun")
    visit sign_in_path
    fill_in "Email", with: "day@night.com"
    fill_in "Password", with: "sun"
    click_on "Sign in"
    click_on "New project"
    fill_in "Name", with: "Biggy"
    click_on "Create Project"
    click_on "Create Task"
    fill_in "Description", with: "David"
    fill_in "Date", with: "11/11/2020"
    click_on "Create Task"
    click_on "Tasks"
    expect(page).to have_content("David")
    expect(page).to have_content("11/11/2020")
    find(".glyphicon.glyphicon-remove").click
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("11/11/2020")
  end

  # scenario "Click all vs incomplete" do
  #   @user = User.create!(first_name: "Day", last_name:"Night",
  #   email: "day@night.com", password: "sun",
  #   password_confirmation: "sun")
  #   visit sign_in_path
  #   fill_in "Email", with: "day@night.com"
  #   fill_in "Password", with: "sun"
  #   click_on "Sign in"
  #   click_on "New project"
  #   fill_in "Name", with: "Biggy"
  #   click_on "Create Project"
  #   expect(page).to have_no_content("David")
  #   expect(page).to have_no_content("12/12/2020")
  #   click_on "Create Task"
  #   fill_in "Description", with: "David"
  #   fill_in "Date", with: "11/11/2020"
  #   click_on "Create Task"
  #   click_on "Edit"
  #   check('Complete')
  #   click_on "Update Task"
  #   expect(page).to have_content("David")
  #   expect(page).to have_content("11/11/2020")
  #   expect(page).to have_no_content("billy")
  #   expect(page).to have_no_content("12/12/2020")
  #   click_on "Tasks"
  #   click_on "Create Task"
  #   fill_in "Description", with: "billy"
  #   fill_in "Date", with: "12/12/2020"
  #   click_on "Create Task"
  #   click_on "Tasks"
  #   expect(page).to have_no_content("David")
  #   expect(page).to have_content("12/12/2020")
  #   expect(page).to have_content("billy")
  #   expect(page).to have_no_content("12/12/2014")
  #   click_on "All"
  #   expect(page).to have_content("David")
  #   expect(page).to have_content("11/11/2020")
  #   expect(page).to have_content("billy")
  #   expect(page).to have_content("12/12/2020")
  #   click_on "Incomplete"
  #   expect(page).to have_no_content("David")
  #   expect(page).to have_no_content("11/11/2020")
  #   expect(page).to have_content("billy")
  #   expect(page).to have_content("12/12/2020")
  #   find(".glyphicon.glyphicon-remove").click
  #   expect(page).to have_no_content("David")
  #   expect(page).to have_no_content("11/11/2020")
  #   expect(page).to have_no_content("billy")
  #   expect(page).to have_no_content("12/12/2020")
  #   click_on "All"
  #   expect(page).to have_content("David")
  #   expect(page).to have_content("11/11/2020")
  # end
end

feature "tasks validation" do

  scenario "tasks description validation can't be blank" do
    @user = User.create!(first_name: "Day", last_name:"Night",
    email: "day@night.com", password: "sun",
    password_confirmation: "sun")
    visit sign_in_path
    fill_in "Email", with: "day@night.com"
    fill_in "Password", with: "sun"
    click_on "Sign in"
    click_on "New project"
    fill_in "Name", with: "Biggy"
    click_on "Create Project"
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("12/12/2020")
    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end

  include ActiveSupport::Testing::TimeHelpers

  scenario "task date select is not before today's date" do
    @user = User.create!(first_name: "Day", last_name:"Night",
    email: "day@night.com", password: "sun",
    password_confirmation: "sun")
    visit sign_in_path
    fill_in "Email", with: "day@night.com"
    fill_in "Password", with: "sun"
    click_on "Sign in"
    click_on "New project"
    fill_in "Name", with: "Biggy"
    click_on "Create Project"
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("12/12/2020")
    click_on "Create Task"
    travel_to(1.day.ago) do
      fill_in "Date", with: Date.today
    end
    click_on "Create Task"
    expect(page).to have_content("Date is not included in the list")
    expect(page).to have_content("Description can't be blank")
    fill_in "Description", with: "bobos"
    fill_in "Date", with: Date.today
    click_on "Create Task"
    expect(page).to have_no_content("Date is not included in the list")
    click_on "Edit"
    fill_in "Date", with: Date.today
  end


end
