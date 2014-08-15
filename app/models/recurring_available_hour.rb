class RecurringAvailableHour < ActiveRecord::Base
	belongs_to :instructor
	has_many :recurring_available_hour_unavailable_period
	belongs_to :recurring_interval
	# validates :hours_from_week_start, :numericality => { :greater_than => 0, :less_than_or_equal_to => 604800 }, :presence => true

end
