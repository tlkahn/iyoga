class CreateNonRecurringAvailableHours < ActiveRecord::Migration
  def change
    create_table :non_recurring_available_hours do |t|
      t.integer :teacher_id
      t.datetime :available_hour_start

      t.timestamps
    end
  end
end
