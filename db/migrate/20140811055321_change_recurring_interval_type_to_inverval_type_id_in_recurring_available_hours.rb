class ChangeRecurringIntervalTypeToInvervalTypeIdInRecurringAvailableHours < ActiveRecord::Migration
  def change
  	rename_column :recurring_available_hours, :recurring_interval, :recurring_interval_id
  end
end
