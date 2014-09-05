class AddWdayToRecurringSchedules < ActiveRecord::Migration
  def change
    add_column :recurring_schedules, :wday_id, :integer
  end
end
