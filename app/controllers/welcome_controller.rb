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

  	@non_recurring_hours = NonRecurringHour.where("available_hour_start >= '#{from_str}' and available_hour_start < '#{to_str}' ")
  	@total_non_recurring_hours = @non_recurring_hours.count


    from_time_since_beginning_of_week = from_time - from_time.beginning_of_week
    to_time_since_beginning_of_week = to_time - to_time.beginning_of_week
    from_time_since_beginning_of_day = from_time - from_time.beginning_of_day
    to_time_since_beginning_of_day = to_time - to_time.beginning_of_day

    recurring_interval_id_week = RecurringInterval.where(name: "week")[0].id
    recurring_interval_id_day = RecurringInterval.where(name: "day")[0].id

    @recurring_available_hours_week = RecurringAvailableHour.where("recurring_interval_id = #{recurring_interval_id_week} and secs_from_start >= #{from_time_since_beginning_of_week} and secs_from_start < #{to_time_since_beginning_of_week}")

    @recurring_available_hours_day = RecurringAvailableHour.where("recurring_interval_id = #{recurring_interval_id_day} and secs_from_start >= #{from_time_since_beginning_of_day} and secs_from_start < #{to_time_since_beginning_of_day}")

  end
end
