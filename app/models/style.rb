class Style < ActiveRecord::Base
	has_many :students, through: :style_followings
	has_many :style_followings
end
