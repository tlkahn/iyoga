class NonRecurringHoursController < ApplicationController
  before_action :set_non_recurring_hour, only: [:show, :edit, :update, :destroy]
  before_action :set_instructor_options, only: [:new, :edit]

  # GET /non_recurring_hours
  # GET /non_recurring_hours.json
  def index
    @non_recurring_hours = NonRecurringHour.all
    @instructor = Instructor.find params[:instructor_id]
  end

  # GET /non_recurring_hours/1
  # GET /non_recurring_hours/1.json
  def show
  end

  # GET /non_recurring_hours/new
  def new
    @non_recurring_hour = NonRecurringHour.new
    @instructor = Instructor.find params[:instructor_id]
  end

  # GET /non_recurring_hours/1/edit
  def edit
  end

  # POST /non_recurring_hours
  # POST /non_recurring_hours.json
  def create
    @non_recurring_hour = NonRecurringHour.new(non_recurring_hour_params)
    @instructor = Instructor.find params[:instructor_id]
    @non_recurring_hour.instructor_id = @instructor.id
    respond_to do |format|
      if @non_recurring_hour.save
        format.html { redirect_to instructor_non_recurring_hours_path, notice: 'Non recurring hour was successfully created.' }
        format.json { render :show, status: :created, location: instructor_non_recurring_hour_path(@instructor) }
      else
        format.html { render :new }
        format.json { render json: instructor_non_recurring_hour_path(@instructor).errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /non_recurring_hours/1
  # PATCH/PUT /non_recurring_hours/1.json
  def update
    respond_to do |format|
      if @non_recurring_hour.update(non_recurring_hour_params)
        format.html { redirect_to instructor_non_recurring_hour_path(@instructor, @non_recurring_hour), notice: 'Non recurring hour was successfully updated.' }
        format.json { render :show, status: :ok, location: instructor_non_recurring_hour_path(@instructor, @non_recurring_hour) }
      else
        format.html { render :edit }
        format.json { render json: @non_recurring_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /non_recurring_hours/1
  # DELETE /non_recurring_hours/1.json
  def destroy
    @non_recurring_hour.destroy
    respond_to do |format|
      format.html { redirect_to instructor_non_recurring_hours_url(@instructor), notice: 'Non recurring hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_non_recurring_hour
      @non_recurring_hour = NonRecurringHour.find(params[:id])
      @instructor = Instructor.find params[:instructor_id]
    end

    def set_instructor_options
      @instructors = Instructor.all
      @instructor_select_options = @instructors.collect do |i|
        [i.user.email, i.id]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def non_recurring_hour_params
      params.require(:non_recurring_hour).permit(:instructor_id, :available_hour_start)
    end
end
