feature "signup" do

  scenario "checks successful signup" do
    visit users_path
    expect(page).to have_no_content("David")
    expect(page).to have_no_content("Rivers")
    expect(page).to have_no_content("aa@aa.com")
    User.create!(first_name: "David", last_name: "Rivers", email: "aa@aa.com", password: "a", password_confirmation: "a")
    visit users_path
    expect(page).to have_content("David")
    expect(page).to have_content("Rivers")
    expect(page).to have_content("aa@aa.com")
    click_on "edit"
    fill_in "First name", with: "Pavid"
    click_on "Update User"
    expect(page).to have_content("Pavid")
    expect(page).to have_no_content("David")
    click_on "edit"
    click_on "Destroy"
    expect(page).to have_no_content("Rivers")
    expect(page).to have_no_content("aa@aa.com")
  end

  scenario "creates a user from user page logins with user logs out" do
    visit users_path
    expect(page).to have_no_content("User was successfully created.")
    expect(page).to have_no_content("baily@baily.com")
    click_on "Create User"
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "baily"
    fill_in "Email", with: "baily@baily.com"
    fill_in "Password", with: "abc"
    fill_in "Password confirmation", with: "abc"
    click_on "Create User"
    expect(page).to have_content("User was successfully created.")
    expect(page).to have_content("Bill")
    expect(page).to have_content("baily")
    expect(page).to have_content("baily@baily.com")
    click_on "Sign In"
    fill_in "Email", with: "baily@baily.com"
    fill_in "Password", with: "abc"
    click_on "Sign in"
    click_on "Bill baily"
    expect(page).to have_content("Name: Bill baily")
    expect(page).to have_content("email: baily@baily.com")
  end
end
