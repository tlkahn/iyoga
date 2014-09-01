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
      @weekdays = Date::DAYNAMES
      @hours = ["12am"].concat((1..11).to_a.map{|a|a.to_s + "am"}).concat(["12pm"]).concat((1..11).to_a.map{|a|a.to_s + "am"})
    else
      redirect_to :root
    end
  end

  def create_schedule
    byebug
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

    instructor_geolocation = InstructorGeolocation.new
    instructor_geolocation.address = params[:geolocation]

    instructor_geolocation.longitude = params[:lng]
    instructor_geolocation.latitude = params[:lat]
    instructor_geolocation.street = params[:rotue]
    instructor_geolocation.street_number = params[:street_number]
    instructor_geolocation.zip = params[:postal_code]
    instructor_geolocation.city = params[:locality]
    instructor_geolocation.country = params[:country]
    instructor_geolocation.state = params[:administrative_area_level_1]

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
    respond_to do |format|
      if @instructor.update(instructor_params)
        format.html { redirect_to @instructor, notice: 'Instructor was successfully updated.' }
        format.json { render :show, status: :ok, location: @instructor }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instructor
      @instructor = Instructor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instructor_params
      params.require(:instructor).permit(:user_id, :street1, :street2, :city, :state, :country, :zip, :certificates, :teach_since, :styles, :certificate_name)
    end
end
