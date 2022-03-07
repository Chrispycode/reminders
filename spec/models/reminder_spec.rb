require 'rails_helper'

RSpec.describe Reminder, type: :model do
  it "has a valid factory" do
    expect(build(:reminder)).to be_valid
  end

  it "must have an title" do
    expect(build(:reminder, title: "")).not_to be_valid
  end

  it "must have a user_id" do
    expect(build(:reminder, user_id: "")).not_to be_valid
  end

  it "must have a scheduled_day" do
    expect(build(:reminder, scheduled_day: "")).not_to be_valid
  end

  it "must have a scheduled_time" do
    expect(build(:reminder, scheduled_time: "")).not_to be_valid
  end

  describe "#scheduled_date" do
    let(:reminder) { create(:reminder) }

    it "returns a DateTime object" do
      expect(reminder.scheduled_date).to be_a DateTime
    end
  end

  describe "#send_reminder" do
    let!(:reminder) { create(:reminder, scheduled_time: 1.minute.from_now, scheduled_day: 1.day.ago) }

    context "with reminder exists" do
      it "creates delayed job" do
        expect(
          described_class.send_reminder(reminder.id, reminder.updated_at, reminder.scheduled_date)
          ).to be_an(Delayed::Backend::ActiveRecord::Job)
      end
    end

    context "with reminder destroyed" do
      it "returns a info message" do
        allow(Rails.logger).to receive(:info)
        reminder.destroy
        described_class.send_reminder(reminder.id, reminder.updated_at, reminder.scheduled_date)

        expect(Rails.logger).to have_received(:info).with("Reminder not found!")
      end
    end

    context "with reminder updated" do
      it "returns a info message" do
        allow(Rails.logger).to receive(:info)
        described_class.send_reminder(reminder.id, 1.day.ago, reminder.scheduled_date)

        expect(Rails.logger).to have_received(:info).with("Reminder expired!")
      end
    end

    context "with reminder recurrent" do
      it "creates two new jobs (1 mail, 1 reminder)" do
        expect {
          described_class.send_reminder(reminder.id, reminder.updated_at, reminder.scheduled_date)
        }.to change(Delayed::Backend::ActiveRecord::Job, :count).by(+2)
      end
    end

    context "with reminder day in the past" do
      it "creates only 1 delayed job" do
        expect {
          described_class.delay(run_at: 1.minute.ago)
            .send_reminder(reminder.id, reminder.updated_at, reminder.scheduled_date)
        }.to change(Delayed::Backend::ActiveRecord::Job, :count).by(+1)
      end
    end
  end
end
