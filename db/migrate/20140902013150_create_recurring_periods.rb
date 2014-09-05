class CreateRecurringPeriods < ActiveRecord::Migration
  def change
    create_table :recurring_periods do |t|
      t.string :name

      t.timestamps
    end
  end
end
