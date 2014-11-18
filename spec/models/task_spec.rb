require "rails_helper"
describe "Tasks" do

  it "tasks can't have a date in the past" do
    task = Task.create!(description: "hi there", date: Date.today)
    expect(task.errors[:date].present?).to eq(false)
    task = Task.new(description: "hi there", date: (Date.today - 1.day))
    task.valid?
    expect(task.errors[:date].present?).to eq(true)
    task = Task.new(description: "hi there", date: (Date.today + 1.day))
    task.valid?
    expect(task.errors[:date].present?).to eq(false)
  end
end
