class Certificate < ActiveRecord::Base
	belongs_to :institute
	has_many :instructors, :through => :credentials
end
