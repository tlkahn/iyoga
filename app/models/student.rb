class Student < ActiveRecord::Base
	belongs_to :user
	has_one :student_geolocation

  has_attached_file :avatar,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" },
                    :default_url => "avatars/man.png"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def geolocation
    StudentGeolocation.where(student_id: self.id).order("updated_at desc").limit(1).to_a[0]
  end

end
