class Practice < ActiveRecord::Base
	belongs_to :instructor
	belongs_to :style
end
