class AddInstructorIdAndChangeIntervalOfRecurringAvailableHours < ActiveRecord::Migration
  def change
  	add_column :recurring_available_hours, :instructor_id, :integer
  	change_column :recurring_available_hours, :recurring_interval, :string
  end
end
