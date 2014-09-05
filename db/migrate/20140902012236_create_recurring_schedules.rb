class CreateRecurringSchedules < ActiveRecord::Migration
  def change
    create_table :recurring_schedules do |t|
      t.integer :style_id
      t.integer :level_id
      t.integer :recurring_period_id
      t.string :day
      t.time :from
      t.time :to
      t.datetime :until

      t.timestamps
    end
  end
end
