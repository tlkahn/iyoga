class RecurringSchedule < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :style
  belongs_to :level
  belongs_to :day
  has_many :recurring_schedule_exceptions

  validates_presence_of :style_id, :on => :create, :message => "can't be blank"
  validates_presence_of :level_id, :on => :create, :message => "can't be blank"
  validates_presence_of :ice_cube_text, :on => :create, :message => "can't be blank"

  def schedule
    IceCube::Schedule.from_yaml self.ice_cube_text
  end


end
