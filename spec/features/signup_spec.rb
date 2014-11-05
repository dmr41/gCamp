require 'rails_helper'

feature "signup" do

  scenario "checks successful signup" do
    visit users_path
    expect(page).to have_no_content("Bill")
    expect(page).to have_no_content("bally")
    expect(page).to have_no_content("baily@baily.com")
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "bally"
    fill_in "Email", with: "baily@baily.com"
    fill_in "Password", with: "abc"
    fill_in "Password confirmation", with: "abc"
    click_on "Sign up"
    visit users_path
    expect(page).to have_content("Bill")
    expect(page).to have_content("bally")
    expect(page).to have_content("baily@baily.com")
  end

  scenario "checks blank password_and_email" do
    visit users_path
    click_on "Sign Up"
    expect(page).to have_no_content("Email can't be blank")
    expect(page).to have_no_content("Password can't be blank")
    click_on "Sign up"
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario "checks blank password" do
    visit users_path
    click_on "Sign Up"
    expect(page).to have_no_content("Password can't be blank")
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "bally"
    fill_in "Email", with: "baily@baily.com"
    click_on "Sign up"
    expect(page).to have_content("Password can't be blank")
  end

  scenario "Sign in" do
    User.create!(first_name: "mooo", last_name: "cow", email: "a@b.com", password: "a", password_confirmation: "a")
    visit users_path
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "a@b.com"
    fill_in "Password", with: "a"
    click_on "Sign in"
  end

  scenario "Sign up with existing email" do
    User.create!(first_name: "mooo", last_name: "cow", email: "a@b.com", password: "a", password_confirmation: "a")
    visit root_path
    click_on "Sign Up"
    expect(page).to have_no_content("Email has already been taken")
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "bally"
    fill_in "Email", with: "a@b.com"
    fill_in "Password", with: "a"
    fill_in "Password confirmation", with: "a"
    click_on "Sign up"
    expect(page).to have_content("Email has already been taken")
  end

  scenario "Sign up with existing email" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "bally"
    fill_in "Email", with: "a@b.com"
    fill_in "Password", with: "a"
    fill_in "Password confirmation", with: "a"
    click_on "Sign up"
    click_on "Sign Out"
    expect(page).to have_content("Sign In")

  end

end
