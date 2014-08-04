class CreateRecurringAvailableHours < ActiveRecord::Migration
  def change
    create_table :recurring_available_hours do |t|
      t.integer :teacher_id
      t.datetime :starting_time
      t.integer :recurring_interval
      t.integer :hours_from_week_start

      t.timestamps
    end
  end
end
