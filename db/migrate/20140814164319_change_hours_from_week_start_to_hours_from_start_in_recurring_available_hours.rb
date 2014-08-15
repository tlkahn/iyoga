class ChangeHoursFromWeekStartToHoursFromStartInRecurringAvailableHours < ActiveRecord::Migration
  def change
  	rename_column :recurring_available_hours, :hours_from_week_start, :hours_from_start
  end
end
