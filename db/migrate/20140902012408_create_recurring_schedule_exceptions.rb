class CreateRecurringScheduleExceptions < ActiveRecord::Migration
  def change
    create_table :recurring_schedule_exceptions do |t|
      t.integer :recurring_schedule_id
      t.date :day

      t.timestamps
    end
  end
end
