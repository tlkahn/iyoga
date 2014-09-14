class WelcomeController < ApplicationController
  def index
    if current_user && current_user.student && current_user.student.geolocation.address
      @address = current_user.student.geolocation.address
    else
      @address = "San Francisco, CA, US"
    end
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

    @result = {}
    @instructors_by_location.each do |instructor_by_location|
      @instructor = instructor_by_location.instructor
      @instructor.recurring_schedules.each do |recurring_schedule|
        occurrences = recurring_schedule.occurrences_on(@from_date)
        puts occurrences
        unless @result[@instructor.id]
          @result[@instructor.id] = occurrences
        else
          @result[@instructor.id] = @result[@instructor.id].concat occurrences
        end
      end
    end

    respond_to do |format|
        format.html {}
        format.json { render json: @result, status: :search_completed }
    end

  end
end
