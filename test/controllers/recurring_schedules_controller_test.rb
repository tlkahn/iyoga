require 'test_helper'

class RecurringSchedulesControllerTest < ActionController::TestCase
  setup do
    @recurring_schedule = recurring_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurring_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recurring_schedule" do
    assert_difference('RecurringSchedule.count') do
      post :create, recurring_schedule: { day: @recurring_schedule.day, from: @recurring_schedule.from, level_id: @recurring_schedule.level_id, recurring_period_id: @recurring_schedule.recurring_period_id, style_id: @recurring_schedule.style_id, to: @recurring_schedule.to, until: @recurring_schedule.until }
    end

    assert_redirected_to recurring_schedule_path(assigns(:recurring_schedule))
  end

  test "should show recurring_schedule" do
    get :show, id: @recurring_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recurring_schedule
    assert_response :success
  end

  test "should update recurring_schedule" do
    patch :update, id: @recurring_schedule, recurring_schedule: { day: @recurring_schedule.day, from: @recurring_schedule.from, level_id: @recurring_schedule.level_id, recurring_period_id: @recurring_schedule.recurring_period_id, style_id: @recurring_schedule.style_id, to: @recurring_schedule.to, until: @recurring_schedule.until }
    assert_redirected_to recurring_schedule_path(assigns(:recurring_schedule))
  end

  test "should destroy recurring_schedule" do
    assert_difference('RecurringSchedule.count', -1) do
      delete :destroy, id: @recurring_schedule
    end

    assert_redirected_to recurring_schedules_path
  end
end
