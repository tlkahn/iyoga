class RecurringSchedule < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :style
  belongs_to :level
  belongs_to :day
  has_many :recurring_schedule_exceptions

  validates_presence_of :style_id, :on => :create, :message => "can't be blank"
  validates_presence_of :level_id, :on => :create, :message => "can't be blank"
  validates_presence_of :ice_cube_text, :on => :create, :message => "can't be blank"

  scope :weekly, -> {where('recurring_period=?', 'weekly')}
  scope :daily, -> {where('recurring_period=?', 'daily')}
  scope :onetime, -> {where('recurring_period=?', 'onetime')}

  def schedule
    schedule = IceCube::Schedule.from_yaml self.ice_cube_text
    if self.is_whole_day
      schedule.start_time = self.from.beginning_of_day
      schedule.duration = 3600*24
    end
    return schedule
  end


end
