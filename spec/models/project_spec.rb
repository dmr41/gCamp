require "rails_helper"

describe "Projects" do

  it "Projects must have name" do
    project = Project.new
    project.valid?
    expect(project.errors[:name].present?).to eq(true)
  end

  it "Projects must have name" do
    project = Project.create!(name: "Bob")
    project2 = Project.new(name: "Bob")
    project2.valid?
    expect(project2.errors[:name].present?).to eq(true)
  end

end
