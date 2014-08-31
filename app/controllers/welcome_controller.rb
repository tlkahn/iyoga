class WelcomeController < ApplicationController
  def index

  end

  def search
    @date                = params[:date]
    @from                = params[:from]
    @to                  = params[:to]
    @location            = params[:location]
    @style               = params[:style]
    @level               = params[:level]
    @location_name       = params[:locationname]
    @location            = params[:location]
    @longitude = @location.strip.split(",")[1]
    @latitude = @location.strip.split(",")[0]

    @radius = if params[:radius].nil? || params[:radius].length > 0 then 5 else params.radius end

  	if @from.length > 0
  		from_time = Chronic.parse("#{@date} #{@from}")
  	else
  		from_time = Time.new('1900-1-1')
  	end

  	if @to.length > 0
  		to_time = Chronic.parse("#{@date} #{@to}")
  	else
  		to_time = Time.new('9999-12-31')
  	end

  	from_str = from_time.strftime("%Y-%m-%d %H:%M:%S")
  	to_str = to_time.strftime("%Y-%m-%d %H:%M:%S")

    from_time_since_beginning_of_week = from_time - from_time.beginning_of_week
    to_time_since_beginning_of_week   = to_time   - to_time.beginning_of_week
    from_time_since_beginning_of_day  = from_time - from_time.beginning_of_day
    to_time_since_beginning_of_day    = to_time   - to_time.beginning_of_day

    recurring_interval_id_week = RecurringInterval.where(name: "week")[0].id
    recurring_interval_id_day = RecurringInterval.where(name: "day")[0].id

    @instructors_by_location = InstructorGeolocation.where("distance(?, ?, longitude, latitude) < 5", @longitude, @latitude)

    if @instructors_by_location.length > 0
      qualified_instructors = @instructors_by_location.collect {|i| i.instructor_id}.to_s.gsub("[","(").gsub("]", ")")

      @non_recurring_hours = NonRecurringHour.where("available_hour_start >=  ? and available_hour_start <  ? and instructor_id in #{qualified_instructors} ", from_str, to_str)
      @total_non_recurring_hours = @non_recurring_hours.count

      @recurring_available_hours_week = RecurringAvailableHour.where("recurring_interval_id = ? and secs_from_start >= ? and secs_from_start < ? and instructor_id in #{qualified_instructors}", recurring_interval_id_week, from_time_since_beginning_of_week, to_time_since_beginning_of_week)
      @recurring_available_hours_day = RecurringAvailableHour.where("recurring_interval_id = ? and secs_from_start >= ? and secs_from_start < ? and instructor_id in #{qualified_instructors}", recurring_interval_id_day, from_time_since_beginning_of_day, to_time_since_beginning_of_day)
    else
      redirect_to :back, :notice => "no classes found"
    end



  end
end
