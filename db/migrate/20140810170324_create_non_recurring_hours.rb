class CreateNonRecurringHours < ActiveRecord::Migration
  def change
    create_table :non_recurring_hours do |t|
      t.integer :instructor_id
      t.datetime :available_hour_start

      t.timestamps
    end
  end
end
