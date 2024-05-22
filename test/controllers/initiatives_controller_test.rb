require 'test_helper'

class InitiativesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @user = users(:default_user)
    sign_in @user
  end

  test "should get index" do
    get "/initiatives"
    assert_response :success
  end

  test "should show initiative" do
    get "/initiatives/#{@initiative.id}"
    assert_response :success
  end

  test "should create initiative" do
    assert_difference('Initiative.count') do
      post "/initiatives", params: { name: "Test Initiative", topic: "Test Topic", description: "Test Description" }
    end
  end

  test "admin user should be recognized as admin" do
    @user.add_role :admin_initiative, @initiative
    assert @user.has_role?(:admin_initiative, @initiative)
  end

  test "should update initiative" do
    @new_initiative = Initiative.create(name: "Test Initiative", topic: "Test Topic", description: "Test Description")
    @user.add_role(:admin_initiative, @new_initiative)

    patch "/initiatives/#{@new_initiative.id}", params: { initiative: { name: "New Name", topic: "New Topic", description: "New Description" } }
    #assert_redirected_to initiative_path(@initiative)
    @new_initiative.reload
    assert_equal "New Name", @new_initiative.name
  end


end