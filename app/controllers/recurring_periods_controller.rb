class RecurringPeriodsController < ApplicationController
  before_action :set_recurring_period, only: [:show, :edit, :update, :destroy]

  # GET /recurring_periods
  # GET /recurring_periods.json
  def index
    @recurring_periods = RecurringPeriod.all
  end

  # GET /recurring_periods/1
  # GET /recurring_periods/1.json
  def show
  end

  # GET /recurring_periods/new
  def new
    @recurring_period = RecurringPeriod.new
  end

  # GET /recurring_periods/1/edit
  def edit
  end

  # POST /recurring_periods
  # POST /recurring_periods.json
  def create
    @recurring_period = RecurringPeriod.new(recurring_period_params)

    respond_to do |format|
      if @recurring_period.save
        format.html { redirect_to @recurring_period, notice: 'Recurring period was successfully created.' }
        format.json { render :show, status: :created, location: @recurring_period }
      else
        format.html { render :new }
        format.json { render json: @recurring_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurring_periods/1
  # PATCH/PUT /recurring_periods/1.json
  def update
    respond_to do |format|
      if @recurring_period.update(recurring_period_params)
        format.html { redirect_to @recurring_period, notice: 'Recurring period was successfully updated.' }
        format.json { render :show, status: :ok, location: @recurring_period }
      else
        format.html { render :edit }
        format.json { render json: @recurring_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurring_periods/1
  # DELETE /recurring_periods/1.json
  def destroy
    @recurring_period.destroy
    respond_to do |format|
      format.html { redirect_to recurring_periods_url, notice: 'Recurring period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurring_period
      @recurring_period = RecurringPeriod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recurring_period_params
      params.require(:recurring_period).permit(:name)
    end
end
