class Style < ActiveRecord::Base
	has_many :practices
	has_many :instructors, :through => :practices
end
