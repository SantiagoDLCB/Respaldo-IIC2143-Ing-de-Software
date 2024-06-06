require "test_helper"

class Users::SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:default_user)  # Usuario de ejemplo para las pruebas
  end

  test "should get sign in page" do
    get new_user_session_path
    assert_response :success
  end

  test "should sign in user" do
    post user_session_path, params: { user: { email: @user.email, password: 'password123' } }
    assert_redirected_to initiatives_path
    # assert warden.authenticated?(:user)
  end

  test "should not sign in user with invalid credentials" do
    post user_session_path, params: { user: { email: @user.email, password: 'wrongpassword' } }
    assert_response :unprocessable_entity
  end

  test "should sign out user" do
    sign_in @user
    delete destroy_user_session_path
    assert_response :redirect
    # assert_not warden.authenticated?(:user)
  end

  # Puedes agregar más pruebas según tus necesidades y personalizaciones
end
