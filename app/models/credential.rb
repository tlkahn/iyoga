class Credential < ActiveRecord::Base
	belongs_to :instructor
	belongs_to :certificate
end
