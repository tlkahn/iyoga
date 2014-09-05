class AddIsWholeDayToRecurringSchedules < ActiveRecord::Migration
  def change
    add_column :recurring_schedules, :is_whole_day, :boolean
  end
end
