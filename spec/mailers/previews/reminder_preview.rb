# Preview all emails at http://localhost:3000/rails/mailers/reminder
class ReminderPreview < ActionMailer::Preview
  def send_reminder
    ReminderMailer.send_reminder(Reminder.first)
  end
end
