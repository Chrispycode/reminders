class Reminder < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :scheduled_day, :scheduled_time
end
