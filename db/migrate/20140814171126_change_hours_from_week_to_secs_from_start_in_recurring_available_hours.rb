class ChangeHoursFromWeekToSecsFromStartInRecurringAvailableHours < ActiveRecord::Migration
  def change
  	rename_column :recurring_available_hours, :hours_from_start, :secs_from_start
  end
end
