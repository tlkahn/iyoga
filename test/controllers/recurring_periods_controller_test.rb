require 'test_helper'

class RecurringPeriodsControllerTest < ActionController::TestCase
  setup do
    @recurring_period = recurring_periods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recurring_periods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recurring_period" do
    assert_difference('RecurringPeriod.count') do
      post :create, recurring_period: { name: @recurring_period.name }
    end

    assert_redirected_to recurring_period_path(assigns(:recurring_period))
  end

  test "should show recurring_period" do
    get :show, id: @recurring_period
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recurring_period
    assert_response :success
  end

  test "should update recurring_period" do
    patch :update, id: @recurring_period, recurring_period: { name: @recurring_period.name }
    assert_redirected_to recurring_period_path(assigns(:recurring_period))
  end

  test "should destroy recurring_period" do
    assert_difference('RecurringPeriod.count', -1) do
      delete :destroy, id: @recurring_period
    end

    assert_redirected_to recurring_periods_path
  end
end
