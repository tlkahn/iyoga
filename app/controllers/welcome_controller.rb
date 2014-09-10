class WelcomeController < ApplicationController
  def index

  end

  def search
    @date          = params[:date]
    @from          = params[:from]
    @to            = params[:to]
    @location      = params[:location]
    @style         = params[:style]
    @level         = params[:level]
    @location_name = params[:locationname]
    @location      = params[:location]
    @longitude     = @location.strip.split(",")[1]
    @latitude      = @location.strip.split(",")[0]

    @radius = if params[:radius].nil? || params[:radius].length > 0 then 5 else params.radius end

  	if @from.length > 0
  		from_date = Chronic.parse @date
  	else
  		from_date = Chronic.parse('today')
  	end

    to_date = from_date.tomorrow

  	from_str = from_date.strftime("%Y-%m-%d %H:%M:%S")
  	to_str = to_date.strftime("%Y-%m-%d %H:%M:%S")

    from_date_since_beginning_of_week = from_date - from_date.beginning_of_week
    to_date_since_beginning_of_week   = to_date   - to_date.beginning_of_week
    from_date_since_beginning_of_day  = from_date - from_date.beginning_of_day
    to_date_since_beginning_of_day    = to_date   - to_date.beginning_of_day

    recurring_interval_id_week = RecurringInterval.where(name: "week")[0].id
    recurring_interval_id_day = RecurringInterval.where(name: "day")[0].id

    @instructors_by_location = InstructorGeolocation.where(id: InstructorGeolocation.where("distance(?, ?, longitude, latitude) < 5", @longitude, @latitude).group('instructor_id').select('max(id)'))

    results = []
    @instructors_by_location.each do |instructor_by_location|
      instructor_by_location.instructor.recurring_schedules.each do |recurring_schedule|
        schedule = recurring_schedule.schedule
        schedule.occurrences_between(from_date, to_date).each do |occurrence|
          r = Hash.new
          r["instructor"]             = instructor_by_location.instructor
          r["schedule"]               = Hash.new
          r["schedule"]["start_time"] = schedule.start_time
          r["schedule"]["end_time"]   = schedule.end_time
          r["schedule"]["details"]    = schedule.to_s
          results.push r
        end
      end
    end

    render :json => results



  end
end
