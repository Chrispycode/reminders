class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :body
      t.belongs_to :user, null: false, foreign_key: true
      t.time :scheduled_time
      t.integer :scheduled_day

      t.timestamps
    end
  end
end
