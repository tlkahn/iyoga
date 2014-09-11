class InstructorGeolocation < ActiveRecord::Base
	belongs_to :instructor

  scope :find_by_location, -> (lng, lat, r) {
    where(id: InstructorGeolocation.where("distance(?, ?, longitude, latitude) < ?", lng, lat, r).group('instructor_id').select('max(id)'))
  }

end
