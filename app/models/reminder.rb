class Reminder < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :scheduled_day, :scheduled_time

  def scheduled_date
    day   = scheduled_day
    month = Time.current.day <= day ? Time.current.month : Time.current.month + 1
    time  = scheduled_time.utc
    hour  = time.hour
    min   = time.min
    DateTime.civil(Time.current.year, Time.current.month, valid_day(day), hour, min).utc.to_datetime
  end

  def valid_day(day)
    return day if day <= Date.civil(Time.current.year, Time.current.month, -1).day
    -1
  end
end
