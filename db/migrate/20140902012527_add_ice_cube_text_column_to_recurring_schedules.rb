class AddIceCubeTextColumnToRecurringSchedules < ActiveRecord::Migration
  def change
    add_column :recurring_schedules, :ice_cube_text, :text
    add_column :recurring_schedules, :instructor_id, :integer
    remove_column :recurring_schedules, :day
    add_column :recurring_schedules, :day_id, :integer
  end
end
