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
  		@from_date = Chronic.parse @date
  	else
  		@from_date = Chronic.parse('today')
  	end

    @instructors_by_location = InstructorGeolocation.find_by_location @longitude, @latitude, @radius

    @results = []
    @instructors_by_location.each do |instructor_by_location|
      instructor_by_location.instructor.recurring_schedules.each do |recurring_schedule|
        @results.concat recurring_schedule.occurrences_on(@from_date)
      end
    end

    respond_to do |format|
        format.html {}
        format.json { render json: @results, status: :search_completed }
    end

  end
end
