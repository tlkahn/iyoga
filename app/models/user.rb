class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
  	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  	if user
  		return user
  	else
  		registered_user = User.where(:email => auth.info.email).first
  		if registered_user
  			return registered_user
  		else
  			# user = User.create(name:auth.extra.raw_info.name,
  			# 	provider:auth.provider,
  			# 	uid:auth.uid,
  			# 	email:auth.info.email,
  			# 	password:Devise.friendly_token[0,20],
  			# 	)
        user = User.new(name:auth.extra.raw_info.name,
          provider:auth.provider,
          uid:auth.uid,
          email:auth.info.email,
          password:Devise.friendly_token[0,20],
          )
        user.skip_confirmation!
        user.save!
        return user
  		end
  	end
  end
end
