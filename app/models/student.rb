class Student < ActiveRecord::Base
	belongs_to :user
	has_many :styles, through: :style_followings
	has_many :style_followings
end
