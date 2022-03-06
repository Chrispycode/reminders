require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe 'send_reminder' do
    let(:reminder) { create(:reminder) }
    let(:mail) { described_class.send_reminder(reminder) }

    it "renders the headers" do
      expect(mail.subject).to eq(reminder.title)
      expect(mail.to).to eq([reminder.user.email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(reminder.body)
    end
  end
end
