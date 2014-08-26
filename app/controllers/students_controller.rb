class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def edit
    if current_user
      @styles = Style.all
      @old_styles = @student.styles
      @student_geolocation = @student.student_geolocation.nil? ? StudentGeolocation.new : @student.student_geolocation
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
    @student.phone = params["student"]["phone"]
    @student.introduction = params["student"]["introduction"]
    styles = params["student"]["styles"].split(",").collect(&:strip)
    @student.styles = styles

    student_geolocation = @student.student_geolocation.nil? ? StudentGeolocation.new : @student.student_geolocation
    student_geolocation.address = params[:geolocation]

    student_geolocation.longitude = params[:lng]
    student_geolocation.latitude = params[:lat]
    student_geolocation.street = params[:route]
    student_geolocation.street_number = params[:street_number]
    student_geolocation.zip = params[:postal_code]
    student_geolocation.city = params[:locality]
    student_geolocation.country = params[:country]
    student_geolocation.state = params[:administrative_area_level_1]


    respond_to do |format|
      if @student.save
        student_geolocation.student_id = @student.id
        if student_geolocation.save
          format.html { redirect_to @student, notice: 'student was successfully updated.' }
          format.json { render :show, status: :created, location: @student }
        else
          format.html { render :new }
          format.json { render json: @student_geolocation.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end

  end

  protected

  def set_student
    @student = Student.find params[:id]
  end
end
