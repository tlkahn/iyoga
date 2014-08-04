class RecurringAvailableHour < ActiveRecord::Base
	has_many :recurring_available_hour_unavailable_period
end
