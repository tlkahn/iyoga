class RecurringScheduleExceptionsController < ApplicationController
  before_action :set_recurring_schedule_exception, only: [:show, :edit, :update, :destroy]

  # GET /recurring_schedule_exceptions
  # GET /recurring_schedule_exceptions.json
  def index
    @recurring_schedule_exceptions = RecurringScheduleException.all
  end

  # GET /recurring_schedule_exceptions/1
  # GET /recurring_schedule_exceptions/1.json
  def show
  end

  # GET /recurring_schedule_exceptions/new
  def new
    @recurring_schedule_exception = RecurringScheduleException.new
  end

  # GET /recurring_schedule_exceptions/1/edit
  def edit
  end

  # POST /recurring_schedule_exceptions
  # POST /recurring_schedule_exceptions.json
  def create
    @recurring_schedule_exception = RecurringScheduleException.new(recurring_schedule_exception_params)

    respond_to do |format|
      if @recurring_schedule_exception.save
        format.html { redirect_to @recurring_schedule_exception, notice: 'Recurring schedule exception was successfully created.' }
        format.json { render :show, status: :created, location: @recurring_schedule_exception }
      else
        format.html { render :new }
        format.json { render json: @recurring_schedule_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_schedule_exceptions/1
  # PATCH/PUT /recurring_schedule_exceptions/1.json
  def update
    respond_to do |format|
      if @recurring_schedule_exception.update(recurring_schedule_exception_params)
        format.html { redirect_to @recurring_schedule_exception, notice: 'Recurring schedule exception was successfully updated.' }
        format.json { render :show, status: :ok, location: @recurring_schedule_exception }
      else
        format.html { render :edit }
        format.json { render json: @recurring_schedule_exception.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurring_schedule_exceptions/1
  # DELETE /recurring_schedule_exceptions/1.json
  def destroy
    @recurring_schedule_exception.destroy
    respond_to do |format|
      format.html { redirect_to recurring_schedule_exceptions_url, notice: 'Recurring schedule exception was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_schedule_exception
      @recurring_schedule_exception = RecurringScheduleException.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_schedule_exception_params
      params.require(:recurring_schedule_exception).permit(:recurring_schedule_id, :day)
    end
end
