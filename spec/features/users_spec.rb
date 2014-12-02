require 'rails_helper'


feature "signup" do

  scenario "checks successful signup" do
    user = User.create!(first_name: "David", last_name: "Rivers", email: "d@d.com", password: "a", password_confirmation: "a")
    visit root_path
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("Rivers")
    expect(page).to have_no_content("d@d.com")
    click_on "Sign In"
    fill_in "Email", with: "d@d.com"
    fill_in "Password", with: "a"
    click_on "Sign in"
    visit users_path
    expect(page).to have_content("David")
    expect(page).to have_content("Rivers")
    expect(page).to have_content("d@d.com")
    click_on "edit"
    fill_in "First name", with: "Pavid"
    click_on "Update User"
    expect(page).to have_content("Pavid")
    expect(page).to have_no_content("David")
    click_on "edit"
    click_on "Destroy"
    expect(page).to have_no_content("Rivers")
    expect(page).to have_no_content("d@d.com")
  end


end
