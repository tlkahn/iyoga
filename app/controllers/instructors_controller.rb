class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:save_certificate, :save_style, :create_schedule]

  # GET /instructors
  # GET /instructors.json
  def index
    @instructors = Instructor.all
  end

  # GET /instructors/1
  # GET /instructors/1.json
  def show
  end

  # GET /instructors/new
  def new
    if user_signed_in?
      #TODO restructure needed
      # if Instructor.all.collect!{|i| i.user}.uniq.include?(User.find(current_user.id))
      #   redirect_to user_schedule_path(current_user)
      # else
        @instructor = current_user.instructor
        @instructor = Instructor.new
        @certificates = Certificate.all.map {|c| [c.title, c.id]}
        @styles = Style.all.map {|c| [c.name, c.id]}
      # end
    else
      redirect_to new_user_session_path, :notice => "Sign in to be a wonderful teacher"
    end
  end

  # GET /instructors/1/edit
  def edit
    @instructor = current_user.instructor
    if @instructor.id == params[:id].to_i
      @certificates = @instructor.certificates.map {|c| [c.title, c.id]}
      @styles = @instructor.styles.map {|c| [c.name, c.id]}
    end
  end

  def new_certificate
    @instructor = current_user.instructor
    # if @instructor.id == params[:id]
      @certificates = @instructor.certificates.map {|c| [c.title, c.id]}
      @styles = @instructor.styles.map {|c| [c.name, c.id]}
    # else
      # render :back, :flash => "you are not authorized to change"
    # end
  end

  def save_certificate
    @certificate_name = params[:certificate_name]
    if @certificate_name && @certificate_name.length>0
      @instructor = Instructor.uncached_find(current_user.instructor.id)

      @certificate_id = Certificate.find_by_title(@certificate_name).id
      unless @certificate_id.nil?
        @credential = Credential.new
        @credential.instructor_id = @instructor.id
        @credential.certificate_id = @certificate_id
        @credential.save!
        redirect_to instructor_path(@instructor), :notice => "successfully saved."
      else
        redirect_to :back, :notice => "no certificate with this title is found."
      end

    else
      redirect_to :back, :notice => "invalid certificate"
    end
  end

  def schedules
    if current_user
      @instructor = current_user.instructor
      @styles = @instructor.styles
      @levels = Level.all
      @wdays = Date::DAYNAMES
      @hours = get_all_hours
    else
      redirect_to :root
    end
  end

  def create_schedule
    @instructor  = Instructor.find(params[:id])
    style_id     = params[:style]
    level_id     = params[:level]

    wday         = if params[:wday] && params[:wday].length > 0 then params[:wday].downcase else nil end
    day          = params[:day]

    is_whole_day = params[:is_whole_day] == 'on'
    unless is_whole_day
      if day
        from         = Chronic.parse(day + " " + params[:from]).to_s
        to           = Chronic.parse(day + " " + params[:to]).to_s
      else
        from         = Chronic.parse "this " + wday + " " + params[:from].to_s
        to           = Chronic.parse "this " + wday + " " + params[:to].to_s
      end
    else
      if day
        from         = Chronic.parse(day).beginning_of_day.to_s
        to           = Chronic.parse(day).end_of_day.to_s
      else
        from         = Chronic.parse("this " + wday).beginning_of_day.to_s
        to           = Chronic.parse("this " + wday).end_of_day.to_s
      end
    end

    until_date          = if params[:until_date] && params[:until_date].length > 0 then Chronic.parse params[:until_date] else nil end

    params_exception    = params[:exception]
    exceptions          = if params_exception && params_exception.length > 0 then params_exception.map {|e| Chronic.parse e} else [] end

    recurring_period    = params[:recurring_period]

    schedule = IceCube::Schedule.new(start=from, end_time: to)

    if recurring_period == "weekly"
      if until_date
        r = IceCube::Rule.weekly.day(wday.to_sym).until(until_date)
      else
        r = IceCube::Rule.weekly.day(wday.to_sym)
      end

    elsif recurring_period == "daily"
      if until_date
        r = IceCube::Rule.daily.until(until_date)
      else
        r = IceCube::Rule.daily
      end
    end

    schedule.add_recurrence_rule r if r

    saved_exceptions = []
    if exceptions && exceptions.length > 0
      exceptions.each do |e|
        unless e.nil?
          schedule.add_exception_time e
          exception = RecurringScheduleException.new
          exception.day = e
          exception.save!
          saved_exceptions.push exception
        end
      end
    end

    recurring_schedule = RecurringSchedule.new

    recurring_schedule.ice_cube_text = schedule.to_yaml
    recurring_schedule.style_id = style_id
    recurring_schedule.level_id = level_id
    recurring_schedule.wday = wday if wday
    recurring_is_whole_day = is_whole_day

    recurring_schedule.from = from
    recurring_schedule.to = to

    recurring_schedule.is_whole_day = is_whole_day
    recurring_schedule.until = until_date
    recurring_schedule.recurring_period = recurring_period
    recurring_schedule.instructor = @instructor

    recurring_schedule.save!
    saved_exceptions.each do |e|
      e.recurring_schedule_id = recurring_schedule.id
      e.save!
    end

    flash.now[:notice] = "Schedule saved"
    redirect_to instructor_schedules_path(@instructor)

  end

  def new_style
    @instructor = current_user.instructor
    # if @instructor.id == params[:id]
    @styles = @instructor.styles.map {|c| [c.name, c.id]}
    # else
      # render :back, :flash => "you are not authorized to change"
    # end
  end

  def save_style
    @style_name = params[:style_name]
    if @style_name && @style_name.length>0
      @instructor = Instructor.uncached_find(current_user.instructor.id)
      @style_id = Style.find_by_name(@style_name).id
      unless @style_id.nil?
        @practice = Practice.new
        @practice.instructor_id = @instructor.id
        @practice.style_id = @style_id
        @practice.save!
        redirect_to instructor_path(@instructor), :notice => "successfully saved."
      else
        redirect_to :back, :notice => "no style with this title is found."
      end
    else
      redirect_to :back, :notice => "invalid style"
    end
  end

  # POST /instructors
  # POST /instructors.json
  def create
    @instructor = Instructor.new(instructor_params)

    instructor_geolocation               = InstructorGeolocation.new
    instructor_geolocation.address       = params[:geolocation]

    instructor_geolocation.longitude     = params[:lng]
    instructor_geolocation.latitude      = params[:lat]
    instructor_geolocation.street        = params[:route]
    instructor_geolocation.street_number = params[:street_number]
    instructor_geolocation.zip           = params[:postal_code]
    instructor_geolocation.city          = params[:locality]
    instructor_geolocation.country       = params[:country]
    instructor_geolocation.state         = params[:administrative_area_level_1]

    @instructor.user_id = current_user.id

    respond_to do |format|
      if @instructor.save
        instructor_geolocation.instructor_id = @instructor.id
        if instructor_geolocation.save
          format.html { redirect_to @instructor, notice: 'Instructor was successfully created.' }
          format.json { render :show, status: :created, location: @instructor }
        else
          format.html { render :new }
          format.json { render json: @instructor_geolocation.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructors/1
  # PATCH/PUT /instructors/1.json
  def update

    instructor_geolocation               = InstructorGeolocation.new
    instructor_geolocation.address       = params[:geolocation]
    instructor_geolocation.longitude     = params[:lng]
    instructor_geolocation.latitude      = params[:lat]
    instructor_geolocation.street        = params[:route]
    instructor_geolocation.street_number = params[:street_number]
    instructor_geolocation.zip           = params[:postal_code]
    instructor_geolocation.city          = params[:locality]
    instructor_geolocation.country       = params[:country]
    instructor_geolocation.state         = params[:administrative_area_level_1]

    respond_to do |format|
      if @instructor.update(instructor_params)
        instructor_geolocation.instructor_id = @instructor.id
        if instructor_geolocation.save
          format.html { redirect_to @instructor, notice: 'Instructor was successfully updated.' }
          format.json { render      :show, status: :ok, location: @instructor }
        else
          format.html { render :new }
          format.json { render json: @instructor_geolocation.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :edit }
        format.json { render json: @instructor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructors/1
  # DELETE /instructors/1.json
  def destroy
    @instructor.destroy
    respond_to do |format|
      format.html { redirect_to instructors_url, notice: 'Instructor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def schedule
    #TODO
    render :text =>  "to show a teacher's schedule"
  end


  def get_occurrences

    @instructor = Instructor.find params[:id]

    current_time = Chronic.parse params[:current_time]

    start_time = current_time.beginning_of_month
    end_time = current_time.end_of_month

    result = []

    @instructor.recurring_schedules.each do |schedule|
      occurrences = IceCube::Schedule.from_yaml(schedule.ice_cube_text).occurrences_between(start_time, end_time)
      occurrences.each do |occurrence|
        if schedule.is_whole_day
          result.push({ :start  =>  occurrence.start_time })
        else
          result.push({ :start  =>  occurrence.start_time, :end  =>  occurrence.end_time })
        end
      end
    end

    result.uniq!

    render json: result

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:user_id, :street1, :street2, :city, :state, :country, :zip, :certificates, :teach_since, :styles, :certificate_name)
    end

    def get_all_hours
      ["12am"].concat((1..11).to_a.map{|a|a.to_s + "am"}).concat(["12pm"]).concat((1..11).to_a.map{|a|a.to_s + "pm"})
    end
end
