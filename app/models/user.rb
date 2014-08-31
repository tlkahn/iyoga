class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  has_one :instructor
  has_one :student

  def is_instructor?
    return ! self.instructor.nil?
  end

  def is_student?
    return self.instructor.nil?
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  	if user
  		return user
  	else
  		registered_user = User.where(:email => auth.info.email).first
  		if registered_user
  			return registered_user
  		else
        user = User.new(name:auth.extra.raw_info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.info.email,
          password:Devise.friendly_token[0,20],
          )
        user.skip_confirmation!
        user.save!
        student = Student.create!
        student.user_id = user.id
        student.save
        return user
  		end
  	end
  end
end
