class RemoveTeacherIdFromRecurringAvailableHours < ActiveRecord::Migration
  def change
  	remove_column :recurring_available_hours, :teacher_id
  end
end
