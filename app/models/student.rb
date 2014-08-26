class Student < ActiveRecord::Base
	belongs_to :user
	has_one :student_geolocation
end
