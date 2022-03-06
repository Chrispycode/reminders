class ReminderMailer < ApplicationMailer
  def send_reminder(reminder)
    @reminder = reminder
    mail(to: @reminder.user.email, subject: @reminder.title)
  end
end
