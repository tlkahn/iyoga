class RecurringSchedulesController < ApplicationController
  before_action :set_recurring_schedule, only: [:show, :edit, :update, :destroy]

  # GET /recurring_schedules
  # GET /recurring_schedules.json
  def index
    @recurring_schedules = RecurringSchedule.all
  end

  # GET /recurring_schedules/1
  # GET /recurring_schedules/1.json
  def show
  end

  # GET /recurring_schedules/new
  def new
    @recurring_schedule = RecurringSchedule.new
  end

  # GET /recurring_schedules/1/edit
  def edit
  end

  # POST /recurring_schedules
  # POST /recurring_schedules.json
  def create
    @recurring_schedule = RecurringSchedule.new(recurring_schedule_params)

    respond_to do |format|
      if @recurring_schedule.save
        format.html { redirect_to @recurring_schedule, notice: 'Recurring schedule was successfully created.' }
        format.json { render :show, status: :created, location: @recurring_schedule }
      else
        format.html { render :new }
        format.json { render json: @recurring_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_schedules/1
  # PATCH/PUT /recurring_schedules/1.json
  def update
    respond_to do |format|
      if @recurring_schedule.update(recurring_schedule_params)
        format.html { redirect_to @recurring_schedule, notice: 'Recurring schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @recurring_schedule }
      else
        format.html { render :edit }
        format.json { render json: @recurring_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurring_schedules/1
  # DELETE /recurring_schedules/1.json
  def destroy
    @recurring_schedule.destroy
    respond_to do |format|
      format.html { redirect_to recurring_schedules_url, notice: 'Recurring schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_schedule
      @recurring_schedule = RecurringSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_schedule_params
      params.require(:recurring_schedule).permit(:style_id, :level_id, :recurring_period_id, :day, :from, :to, :until)
    end
end
