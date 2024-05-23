require 'test_helper'

class InitiativesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @initiative2 = initiatives(:two)
    @user = users(:default_user)
    @normal_user = users(:another_user)

    sign_in @user
    @user.add_role(:admin_initiative, @initiative)
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

  test "should not create initiative with invalid data" do
    assert_no_difference 'Initiative.count' do
      post "/initiatives", params: { name: "", topic: "Test Topic", description: "Test Description" }
    end
    assert_redirected_to root_path
  end

  test "should show error message for duplicate name" do
    post "/initiatives", params: { name: @initiative.name, topic: "Test Topic", description: "Test Description" }
    assert_redirected_to root_path
  end

  test "admin user should be recognized as admin" do
    @user.add_role :admin_initiative, @initiative
    assert @user.has_role?(:admin_initiative, @initiative)
  end

  test "should update initiative" do
    patch initiative_path(@initiative), params: { initiative: { name: "New Name", topic: "New Topic", description: "New Description", update_type: 'data' } }
    assert_redirected_to initiative_path(@initiative)

    @initiative.reload
    assert_equal "New Name", @initiative.name
    assert_equal "New Topic", @initiative.topic
    assert_equal "New Description", @initiative.description
  end

  test "should redirect create when not logged in" do
    sign_out @user
    assert_no_difference 'Initiative.count' do
      post "/initiatives", params: { name: "Test Initiative", topic: "Test Topic", description: "Test Description" }
    end
    assert_redirected_to new_user_session_path
  end

  test "should redirect update when not admin" do
    patch initiative_path(@initiative2), params: { initiative: { name: "New Name", topic: "New Topic", description: "New Description", update_type: 'data' } }
    assert_redirected_to root_path
  end

  test "should add admin role to user" do
    sign_in @normal_user
    @normal_user.add_role(:admin_initiative, @initiative)
    assert @normal_user.has_role?(:admin_initiative, @initiative)
  end

  test "should add admin role to user 2" do
    sign_in @user
    @user.add_role(:admin_initiative, @initiative)
    patch "/initiatives/#{@initiative.id}", params: { initiative: { update_type: 'add_admin', user_id: @user.id } }
    assert_redirected_to initiative_path(@initiative)
    assert @user.has_role?(:admin_initiative, @initiative)
  end

  test "should remove admin role from user" do
    @user.remove_role(:admin_initiative, @initiative)
    assert_not @user.has_role?(:admin_initiative, @initiative)
  end

  test "should remove admin role from user 2" do
    sign_in @user
    @user.add_role(:admin_initiative, @initiative)
    @normal_user.add_role(:admin_initiative, @initiative)
    patch "/initiatives/#{@initiative.id}", params: { initiative: { update_type: 'remove_admin', user_id: @normal_user.id } }
    assert_redirected_to initiative_path(@initiative)
    assert_not @normal_user.has_role?(:admin_initiative, @initiative)
  end

  test "should remove member role from user" do
    @normal_user.add_role(:member, @initiative)
    patch "/initiatives/#{@initiative.id}", params: { initiative: { update_type: 'remove_member', user_id: @normal_user.id } }
    assert_redirected_to initiative_path(@initiative)
    assert_not @normal_user.has_role?(:member, @initiative)
  end

  test "should destroy initiative if admin" do
    @user.add_role(:admin_initiative, @initiative)
    assert_difference 'Initiative.count', -1 do
      delete "/initiatives/#{@initiative.id}"
    end
    assert_redirected_to root_path
  end

  test "should not destroy initiative if not admin" do
    sign_in @normal_user
    assert_no_difference 'Initiative.count' do
      delete "/initiatives/#{@initiative.id}"
    end
    assert_redirected_to root_path
  end
  
end