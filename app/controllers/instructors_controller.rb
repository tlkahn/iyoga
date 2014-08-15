class InstructorsController < ApplicationController
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]

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
      if Instructor.all.collect!{|i| i.user}.uniq.include?(User.find(current_user.id))
        redirect_to user_schedule_path(current_user)
      else
        @instructor = Instructor.new
      end
    else
      redirect_to new_user_session_path, :notice => "Sign in to be a wonderful teacher"
    end
  end

  # GET /instructors/1/edit
  def edit
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
      params.require(:instructor).permit(:user_id, :street1, :street2, :city, :state, :country, :zip, :certificates, :teach_since, :styles)
    end
end
