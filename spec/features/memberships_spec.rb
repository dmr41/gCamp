require 'rails_helper'

feature "memberships" do

  def project_user_seed
    @project = Project.create!(name: "Biggy")
    @user = User.create!(first_name: "Day", last_name:"Night",
                        email: "day@night.com", password: "sun",
                        password_confirmation: "sun")
  end

  scenario "create a membership and delete it" do
    project_user_seed
    visit project_memberships_path(@project)
    expect(page).to have_no_content("Day Night was successfully created.")
    select("Day Night", from: "membership_user_id")
    select("Owner", from: "membership_role")
    click_on "Add New Member"
    expect(page).to have_content("Day Night was successfully created.")
    expect(page).to have_button("Update")
    # find('td/a.glyphicon').click
    find("td/a.glyphicon").click


    expect(page).to have_no_button("Update")
  end

end
