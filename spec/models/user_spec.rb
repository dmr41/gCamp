require 'rails_helper'


describe "User" do

  def create_new_user
    User.create!(first_name: "David",last_name: "Rivers", email: "aa@aa.com", password: "a",password_confirmation: "a")
  end

  def new_user
    User.new(first_name: "David",last_name: "Rivers", email: "aa@aa.com", password: "a",password_confirmation: "a")
  end

  it "validates email regardless of case" do
    user = create_new_user
    expect(user.errors[:email].present?).to eq(false)
    user2 = new_user
    user2.email = "aa@aa.com"
    user2.valid?
    expect(user2.errors[:email].present?).to eq(true)
    user3 = new_user
    user3.email = "AA@AA.com"
    user3.valid?
    expect(user3.errors[:email].present?).to eq(true)
  end

  it "validates email and makes new email" do
    user = create_new_user
    expect(user.errors[:email].present?).to eq(false)
    user2 = new_user
    user2.email = "PP@aa.com"
    user2.valid?
    expect(user2.errors[:email].present?).to eq(false)
  end

end
