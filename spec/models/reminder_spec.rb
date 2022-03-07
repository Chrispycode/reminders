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
    let(:reminder) { create(:reminder) }

    it "returns a DateTime object" do
      expect(reminder.scheduled_date).to be_a DateTime
    end
  end

  describe "#send_reminder" do
    let!(:reminder) { create(:reminder, scheduled_time: 1.minute.from_now, scheduled_day: 1.day.ago) }

    context "reminder exists" do
      it "should create delayed job" do
        expect(Reminder.send_reminder(reminder.id, reminder.updated_at)).to be_an(Delayed::Backend::ActiveRecord::Job)
      end
    end

    context "reminder destroyed" do
      it "should return a info message" do
        allow(Rails.logger).to receive(:info)
        reminder.destroy
        Reminder.send_reminder(reminder.id, reminder.updated_at)

        expect(Rails.logger).to have_received(:info).with("Reminder not found!")
      end
    end

    context "reminder updated" do
      it "should return a info message" do
        allow(Rails.logger).to receive(:info)
        Reminder.send_reminder(reminder.id, 1.day.ago)

        expect(Rails.logger).to have_received(:info).with("Reminder expired!")
      end
    end

    context "reminder recurrent" do
      it "should create two new jobs (1 mail, 1 reminder)" do
        expect {
          Reminder.send_reminder(reminder.id, reminder.updated_at)
        }.to change(Delayed::Backend::ActiveRecord::Job, :count).by(+2)
      end
    end
  end
end
