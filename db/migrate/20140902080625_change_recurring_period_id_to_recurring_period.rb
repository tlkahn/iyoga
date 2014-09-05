class ChangeRecurringPeriodIdToRecurringPeriod < ActiveRecord::Migration
  def change
    remove_column :recurring_schedules, :recurring_period_id
    add_column :recurring_schedules, :recurring_period, :string
  end
end
