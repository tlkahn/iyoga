class ChangeFromAndToTypeToDatetimeInRecurringSchedules < ActiveRecord::Migration
  def change
    remove_column :recurring_schedules, :from
    remove_column :recurring_schedules, :to
    add_column :recurring_schedules, :from, :datetime
    add_column :recurring_schedules, :to, :datetime
  end
end
