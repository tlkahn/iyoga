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

  def occurrences_on(date)
    results = []
    schedule = self.schedule
    from = date.beginning_of_day
    to = date.end_of_day
    schedule.occurrences_between(from, to).each do |occurrence|
      r = Hash.new
      r["instructor"]               = self.instructor
      r["schedule"]                 = Hash.new
      r["schedule"]["is_whole_day"] = self.is_whole_day
      r["schedule"]["start_time"]   = schedule.start_time
      r["schedule"]["end_time"]     = schedule.end_time
      r["schedule"]["details"]      = schedule.to_s
      results.push r
    end
    return results
  end


end
