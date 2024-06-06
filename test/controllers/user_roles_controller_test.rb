require "test_helper"

class UserRolesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @admin = users(:default_user)
    @user = users(:another_user)
    @role_to_remove = Role.create(name: "Test Role")
    @user.add_role(@role_to_remove.name, @initiative)
    sign_in @admin
  end

  # Tests

  test "should remove role from user in initiative" do
    assert @user.has_role?(@role_to_remove.name, @initiative)
    delete initiative_user_role_path(@initiative, @user, role: @role_to_remove.name)
    assert_response :redirect
    assert_not @user.has_role?(@role_to_remove.name, @initiative)
    assert_redirected_to @initiative
  end

  test "should redirect to root if user is not signed in" do
    sign_out @admin
    delete initiative_user_role_path(@initiative, @user, role: @role_to_remove.name)
    assert_redirected_to new_user_session_path
  end

end
