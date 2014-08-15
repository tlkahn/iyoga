class ChangeRecurringIntervalIdToInteger < ActiveRecord::Migration
  def change
  	remove_column :recurring_available_hours, :recurring_interval_id
  	add_column :recurring_available_hours, :recurring_interval_id, :integer
  end
end
