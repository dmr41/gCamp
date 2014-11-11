require 'rails_helper'
require 'spec_helper'

feature "signup" do

  scenario "checks tasks for task creation show and edit" do
    visit tasks_path
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("12/12/2020")
    click_on "Create Task"
    fill_in "Description", with: "David"
    fill_in "Date", with: "12/12/2020"
    click_on "Create Task"
    expect(page).to have_content("David")
    expect(page).to have_content("12/12/2020")
    expect(page).to have_content("Task was successfully created.")
    click_on "Tasks"
    click_on "Show"
    expect(page).to have_content("David")
    expect(page).to have_content("12/12/2020")
    expect(page).to have_no_content("Task was successfully created.")
    click_on "Tasks"
    click_on "Edit"
    fill_in "Description", with: "Billy"
    fill_in "Date", with: "11/11/2020"
    check('Complete')
    click_on "Update Task"
    expect(page).to have_content("Billy")
    expect(page).to have_no_content("11/11/2022")
    expect(page).to have_content("Task was successfully updated.")
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("12/12/2020")
  end

  scenario "checks tasks for task destroy" do
    visit tasks_path
    click_on "Create Task"
    fill_in "Description", with: "David"
    fill_in "Date", with: "11/11/2020"
    click_on "Create Task"
    visit tasks_path
    expect(page).to have_content("David")
    expect(page).to have_content("11/11/2020")
    click_on "Destroy"
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("11/11/2020")
  end

  scenario "Click all vs incomplete" do
    visit tasks_path
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("11/11/2020")
    click_on "Create Task"
    fill_in "Description", with: "David"
    fill_in "Date", with: "11/11/2020"
    click_on "Create Task"
    visit tasks_path
    click_on "Edit"
    check('Complete')
    click_on "Update Task"
    visit tasks_path
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("11/11/2020")
    expect(page).to have_no_content("billy")
    expect(page).to have_no_content("12/12/2020")
    click_on "Create Task"
    fill_in "Description", with: "billy"
    fill_in "Date", with: "12/12/2020"
    click_on "Create Task"
    visit tasks_path
    expect(page).to have_no_content("David")
    expect(page).to have_content("12/12/2020")
    expect(page).to have_content("billy")
    expect(page).to have_no_content("12/12/2014")
    click_on "All"
    expect(page).to have_content("David")
    expect(page).to have_content("11/11/2020")
    expect(page).to have_content("billy")
    expect(page).to have_content("12/12/2020")
    click_on "Incomplete"
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("11/11/2020")
    expect(page).to have_content("billy")
    expect(page).to have_content("12/12/2020")
    click_on "Destroy"
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("11/11/2020")
    expect(page).to have_no_content("billy")
    expect(page).to have_no_content("12/12/2020")
    click_on "All"
    expect(page).to have_content("David")
    expect(page).to have_content("11/11/2020")
  end
end

feature "tasks validation" do

  scenario "tasks description validation can't be blank" do
    visit new_task_path
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")
  end

  include ActiveSupport::Testing::TimeHelpers
  
  scenario "task date select is not before today's date" do
    visit new_task_path
    travel_to(1.day.ago) do
      fill_in "Date", with: Date.today
    end
    click_on "Create Task"
    expect(page).to have_content("Date is not included in the list")
    expect(page).to have_content("Description can't be blank")
    visit new_task_path
    fill_in "Description", with: "bobos"
    fill_in "Date", with: Date.today
    click_on "Create Task"
    expect(page).to have_no_content("Date is not included in the list")
    click_on "Edit"
    fill_in "Date", with: Date.today
  end


end
