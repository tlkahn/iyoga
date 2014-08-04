class CreateRecurringAvailableHourUnavailablePeriods < ActiveRecord::Migration
  def change
    create_table :recurring_available_hour_unavailable_periods do |t|
      t.integer :recurring_available_hour_id
      t.datetime :unavailable_period_start
      t.datetime :unvailable_period_end

      t.timestamps
    end
  end
end
