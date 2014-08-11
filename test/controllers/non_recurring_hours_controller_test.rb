require 'test_helper'

class NonRecurringHoursControllerTest < ActionController::TestCase
  setup do
    @non_recurring_hour = non_recurring_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:non_recurring_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create non_recurring_hour" do
    assert_difference('NonRecurringHour.count') do
      post :create, non_recurring_hour: { available_hour_start: @non_recurring_hour.available_hour_start, instructor_id: @non_recurring_hour.instructor_id }
    end

    assert_redirected_to non_recurring_hour_path(assigns(:non_recurring_hour))
  end

  test "should show non_recurring_hour" do
    get :show, id: @non_recurring_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @non_recurring_hour
    assert_response :success
  end

  test "should update non_recurring_hour" do
    patch :update, id: @non_recurring_hour, non_recurring_hour: { available_hour_start: @non_recurring_hour.available_hour_start, instructor_id: @non_recurring_hour.instructor_id }
    assert_redirected_to non_recurring_hour_path(assigns(:non_recurring_hour))
  end

  test "should destroy non_recurring_hour" do
    assert_difference('NonRecurringHour.count', -1) do
      delete :destroy, id: @non_recurring_hour
    end

    assert_redirected_to non_recurring_hours_path
  end
end
