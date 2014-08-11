class DropNonRecurringAvailableHours < ActiveRecord::Migration
  def change
  	drop_table :non_recurring_available_hours
  end
end
