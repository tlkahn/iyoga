class Instructor < ActiveRecord::Base

  # include IceCube
  # serialize :schedule, IceCube::Schedule

	belongs_to :user
	has_many :non_recurring_hours
	has_many :recurring_available_hours
	has_many :instructor_geolocations
	has_many :credentials
	has_many :certificates, :through => :credentials
	has_many :practices
	has_many :styles, :through => :practices
  has_many :recurring_schedules

	# def address
	# 	return [self.street1, self.street2, self.city, self.state, self.country].inject("") { |x,y|y.nil? ? x : x<<" "<<y }
	# end

	def self.uncached_find(id)
		uncached do
			find(id)
		end
	end

  def geolocation
    InstructorGeolocation.where(instructor_id: 9).order('updated_at desc').limit(1).to_a[0]
  end

end
