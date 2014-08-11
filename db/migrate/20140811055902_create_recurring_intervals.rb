class CreateRecurringIntervals < ActiveRecord::Migration
  def change
    create_table :recurring_intervals do |t|
      t.string :name

      t.timestamps
    end
  end
end
