class Instructor < ActiveRecord::Base
	belongs_to :user
	has_many :non_recurring_hours
	has_many :recurring_available_hours
  validates_presence_of :street1, :city, :state, :country, :zip , :teach_since, :on => :create, :message => "can't be blank"

	def address
		return [self.street1, self.street2, self.city, self.state, self.country].inject("") { |x,y|y.nil? ? x : x<<" "<<y }
	end

end
