class Instructor < ActiveRecord::Base
	belongs_to :user
	has_many :non_recurring_hours
	has_many :recurring_available_hours
	has_many :instructor_geolocations
	has_many :credentials
	has_many :certificates, :through => :credentials
	has_many :practices
	has_many :styles, :through => :practices

	def address
		return [self.street1, self.street2, self.city, self.state, self.country].inject("") { |x,y|y.nil? ? x : x<<" "<<y }
	end

	def self.uncached_find(id)
		uncached do
			find(id)
		end
	end

end
