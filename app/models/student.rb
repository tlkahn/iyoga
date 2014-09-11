class Student < ActiveRecord::Base
	belongs_to :user
	has_one :student_geolocation

  def geolocation
    StudentGeolocation.where(student_id: self.id).order("updated_at desc").limit(1).to_a[0]
  end

end
