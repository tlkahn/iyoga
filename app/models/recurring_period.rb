class RecurringPeriod < ActiveRecord::Base
  has_many :recurring_schedules

  def self.getPeriodName(period_id)
    hash = {
      1  =>  "weekly",
      2  =>  "daily",
      3  =>  "monthly",
      4  =>  "yearly"
    }
    return hash[period_id]
  end
end
