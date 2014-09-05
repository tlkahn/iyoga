require 'test_helper'

class RecurringScheduleExceptionsControllerTest < ActionController::TestCase
  setup do
    @recurring_schedule_exception = recurring_schedule_exceptions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurring_schedule_exceptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recurring_schedule_exception" do
    assert_difference('RecurringScheduleException.count') do
      post :create, recurring_schedule_exception: { day: @recurring_schedule_exception.day, recurring_schedule_id: @recurring_schedule_exception.recurring_schedule_id }
    end

    assert_redirected_to recurring_schedule_exception_path(assigns(:recurring_schedule_exception))
  end

  test "should show recurring_schedule_exception" do
    get :show, id: @recurring_schedule_exception
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recurring_schedule_exception
    assert_response :success
  end

  test "should update recurring_schedule_exception" do
    patch :update, id: @recurring_schedule_exception, recurring_schedule_exception: { day: @recurring_schedule_exception.day, recurring_schedule_id: @recurring_schedule_exception.recurring_schedule_id }
    assert_redirected_to recurring_schedule_exception_path(assigns(:recurring_schedule_exception))
  end

  test "should destroy recurring_schedule_exception" do
    assert_difference('RecurringScheduleException.count', -1) do
      delete :destroy, id: @recurring_schedule_exception
    end

    assert_redirected_to recurring_schedule_exceptions_path
  end
end
