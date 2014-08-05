class Message < ActiveRecord::Base
	validates_presence_of :title, :to_user_id
end
