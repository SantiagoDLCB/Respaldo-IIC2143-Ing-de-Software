require "test_helper"

class Users::PasswordsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:default_user)
  end

  test "should get new password page" do
    get new_user_password_path
    assert_response :success
  end

  test "should send password reset instructions" do
    post user_password_path, params: { user: { email: @user.email } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should not send password reset instructions with invalid email" do
    post user_password_path, params: { user: { email: 'invalid@example.com' } }
    assert_response :unprocessable_entity
  end

  test "should get edit password page" do
    token = @user.send_reset_password_instructions
    get edit_user_password_path(reset_password_token: token)
    assert_response :success
  end

  test "should update password" do
    token = @user.send_reset_password_instructions
    put user_password_path, params: {
      user: {
        reset_password_token: token,
        password: 'newpassword',
        password_confirmation: 'newpassword'
      }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should not update password with invalid token" do
    put user_password_path, params: {
      user: {
        reset_password_token: 'invalid_token',
        password: 'newpassword',
        password_confirmation: 'newpassword'
      }
    }
    assert_response :unprocessable_entity
  end

end
