class Day < ActiveRecord::Base
  has_many :recurring_schedules
end
