class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def edit
    if current_user && current_user.student.id = @student.id
      @old_styles = @student.styles
      @old_practice_since = @student.practice_since
      @student_geolocation = @student.geolocation
    else
      flash[:notice] = 'You have not signed in yet.'
      redirect_to :root
    end
  end

  def show
    unless current_user
      flash[:notice] = 'You have not signed in yet.'
      redirect_to :root
    end
  end

  def update

    @student.phone          = params["student"]["phone"] if params["student"]["phone"]
    @student.introduction   = params["student"]["introduction"].strip if params["student"]["introduction"]
    @student.styles         = params[:styles]
    @student.practice_since = Chronic.parse(params[:practice_since])

    @student_geolocation               = StudentGeolocation.new
    @student_geolocation.address       = params[:geolocation]
    @student_geolocation.longitude     = params[:lng]
    @student_geolocation.latitude      = params[:lat]
    @student_geolocation.street        = params[:route]
    @student_geolocation.street_number = params[:street_number]
    @student_geolocation.zip           = params[:postal_code]
    @student_geolocation.city          = params[:locality]
    @student_geolocation.country       = params[:country]
    @student_geolocation.state         = params[:administrative_area_level_1]
    @student_geolocation.student_id    = @student.id

    if @student.save && @student_geolocation.save
    respond_to do |format|
        format.html { redirect_to @student, notice: 'student was successfully updated.' }
        format.json { render :show, status: :created, location: @student }
    end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @student_geolocation.errors, status: :unprocessable_entity }
      end
    end

  end

  protected

  def set_student
    @student = Student.find params[:id]
  end
end
