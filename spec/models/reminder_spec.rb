require 'rails_helper'

RSpec.describe Reminder, type: :model do
  it "has a valid factory" do
    expect(build(:reminder)).to be_valid
  end

  it "must have an title" do
    expect(build(:reminder, title: "")).to_not be_valid
  end

  it "must have a user_id" do
    expect(build(:reminder, user_id: "")).to_not be_valid
  end

  it "must have a scheduled_day" do
    expect(build(:reminder, scheduled_day: "")).to_not be_valid
  end

  it "must have a scheduled_time" do
    expect(build(:reminder, scheduled_time: "")).to_not be_valid
  end

  describe "#scheduled_date" do
    let(:reminder) {create(:reminder)}

    it "returns a DateTime object" do
      expect(reminder.scheduled_date).to be_a DateTime
    end
  end
end
