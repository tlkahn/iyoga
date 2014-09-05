class ChangeWdayIdToWdayInRecurringSchedules < ActiveRecord::Migration
  def change
    remove_column :recurring_schedules, :wday_id
    add_column :recurring_schedules, :wday, :string
  end
end
