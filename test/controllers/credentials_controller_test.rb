require 'test_helper'

class CredentialsControllerTest < ActionController::TestCase
  setup do
    @credential = credentials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:credentials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create credential" do
    assert_difference('Credential.count') do
      post :create, credential: { certificate_id: @credential.certificate_id, instructor_id: @credential.instructor_id }
    end

    assert_redirected_to credential_path(assigns(:credential))
  end

  test "should show credential" do
    get :show, id: @credential
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @credential
    assert_response :success
  end

  test "should update credential" do
    patch :update, id: @credential, credential: { certificate_id: @credential.certificate_id, instructor_id: @credential.instructor_id }
    assert_redirected_to credential_path(assigns(:credential))
  end

  test "should destroy credential" do
    assert_difference('Credential.count', -1) do
      delete :destroy, id: @credential
    end

    assert_redirected_to credentials_path
  end
end
