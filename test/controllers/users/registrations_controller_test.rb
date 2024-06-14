require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:default_user) # Usuario de ejemplo para las pruebas
  end

  test "should get sign up page" do
    get new_user_registration_path
    assert_response :success
  end

  test "should create user" do
    assert_difference 'User.count', 1 do
      post user_registration_path, params: {
        user: {
          email: 'newuser@uc.cl',
          password: 'password',
          password_confirmation: 'password',
          username: 'newuser',
          name: 'New',
          last_name: 'User'
        }
      }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

  test "should not create user with invalid data" do
    assert_no_difference 'User.count' do
      post user_registration_path, params: {
        user: {
          email: 'invalidemail',
          password: 'short',
          password_confirmation: 'short',
          username: 'newuser',
          name: 'New',
          last_name: 'User'
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit page" do
    sign_in @user
    get edit_user_registration_path
    assert_response :success
  end

  test "should update user" do
    sign_in @user
    patch user_registration_path, params: {
      user: {
        current_password: 'password123',
        email: 'updateduser@uc.cl',
        username: 'updateduser',
        name: 'Updated',
        last_name: 'User'
      }
    }
    assert_response :redirect
  end

  test "should not update user with invalid data" do
    sign_in @user
    patch user_registration_path, params: {
      user: {
        current_password: 'password',
        email: 'invalidemail',
        username: 'updateduser',
        name: 'Updated',
        last_name: 'User'
      }
    }
    assert_response :unprocessable_entity
  end

  test "should destroy user" do
    sign_in @user
    assert_difference 'User.count', -1 do
      delete user_registration_path
    end
    assert_response :redirect
  end
end
