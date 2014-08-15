class RecurringAvailableHoursController < ApplicationController
	before_action :set_recurring_available_hour, only: [:show, :edit, :update, :destroy]
  before_action :set_instructor_options, only: [:new, :edit]

  def index
  	@recurring_available_hours = RecurringAvailableHour.all.order :updated_at
  	@instructor = Instructor.find params[:instructor_id]
  end

  def new
  	@recurring_available_hour = RecurringAvailableHour.new
  	@instructor = Instructor.find params[:instructor_id]
  end

  def edit
  end

  def create
  	@recurring_available_hour = RecurringAvailableHour.new(recurring_available_hour_params)
    @recurring_available_hour.recurring_interval_id = recurring_available_hour_params[:recurring_interval_id]
  	@instructor = Instructor.find recurring_available_hour_params[:instructor_id]
  	@recurring_available_hour.instructor_id = @instructor.id
  	respond_to do |format|
  		if @recurring_available_hour.save
  			format.html { redirect_to instructor_recurring_available_hours_path, notice: 'New recurring available hour was successfully created.' }
  			format.json { render :show, status: :created, location: instructor_recurring_available_hour_path(@instructor) }
  		else
  			format.html { redirect_to :back, :notice => @recurring_available_hour.errors.full_messages.to_sentence }
  			format.json { render json: @recurring_available_hour.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # PATCH/PUT /recurring_available_hours/1
  # PATCH/PUT /recurring_available_hours/1.json
  def update
  	respond_to do |format|
  		if @recurring_available_hour.update(recurring_available_hour_params)
  			format.html { redirect_to instructor_recurring_available_hours_path(@instructor), notice: 'Non recurring hour was successfully updated.' }
  			format.json { render :show, status: :ok, location: instructor_recurring_available_hour_path(@instructor, @recurring_available_hour) }
  		else
  			format.html { render :edit }
  			format.json { render json: @recurring_available_hour.errors, status: :unprocessable_entity }
  		end
  	end
  end

  # DELETE /recurring_available_hours/1
  # DELETE /recurring_available_hours/1.json
  def destroy
  	@recurring_available_hour.destroy
  	respond_to do |format|
  		format.html { redirect_to instructor_recurring_available_hours_url(@instructor), notice: 'Non recurring hour was successfully destroyed.' }
  		format.json { head :no_content }
  	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_available_hour
    	@recurring_available_hour = RecurringAvailableHour.find(params[:id])
    	@instructor = Instructor.find params[:instructor_id]
    end

    def set_instructor_options
    	@instructors = Instructor.all
    	@instructor_select_options = @instructors.collect do |i|
    		[i.user.email, i.id]
    	end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_available_hour_params
    	params.require(:recurring_available_hour).permit(:instructor_id, :secs_from_start, :recurring_interval_id)
    end
  end
