require "test_helper"

class RequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @request = requests(:one)
    @initiative = initiatives(:one)
    @user = users(:default_user)
    @normal_user = users(:another_user)
    sign_in @user
  end

  test "should get index" do
    get initiative_requests_path(@initiative)
    assert_not_nil assigns(:all_requests)
    assert_not_nil assigns(:active_requests)
    assert_not_nil assigns(:old_requests)
  end

  test "should create request" do
    @third_user = users(:third_user)
    sign_in @third_user
    assert_difference('Request.count') do
      post requests_path(@initiative), params: { request: { status: "pending", initiative: @initiative.id } }
    end
    assert_redirected_to initiative_path(@initiative)
  end

  test "should update request status" do
    @fourth_user = users(:fourth_user)
    sign_in @fourth_user
    patch request_path(@request), params: { request: { status: "accepted" } }
    assert_redirected_to initiative_path(@initiative)

    assert_equal "Aceptada", flash[:notice]
  end

end
