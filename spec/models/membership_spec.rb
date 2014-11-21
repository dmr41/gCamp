require "rails_helper"

describe "Memberships" do

  it "Memberships must have users but can't be added twice" do
    user = User.create!(first_name: "David", last_name: "Rios", email: "d@d.com", password: "a", password_confirmation: "a")
    project = Project.create!(name: "Victor")
    membership = project.memberships.create!(role: "member", user_id: user.id)
    ndmember = project.memberships.new(role: "member", user_id: user.id)
    ndmember.valid?
    expect(ndmember.errors[:user_id].present?).to eq(true)
  end

  it "Memberships must have users to be validated and created" do
    user = User.create!(first_name: "David", last_name: "Rios", email: "d@d.com", password: "a", password_confirmation: "a")
    project = Project.create!(name: "Victor")
    membership = project.memberships.new(role: "member")
    membership.valid?
    expect(membership.errors[:user_id].present?).to eq(true)
  end

end
