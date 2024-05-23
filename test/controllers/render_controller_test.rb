# frozen_string_literal: true

require 'test_helper'

class RenderControllerTest < ActionDispatch::IntegrationTest

  setup do
    @recent_initiatives = Initiative.order(created_at: :desc).limit(3)
    @user = users(:default_user)
  end

  test 'should get index' do
    get root_url
    assert_response :success
  end

  test "should show recent initiatives" do
    get root_url
    assert_not_nil assigns(:recent_initiatives)
    assert_equal @recent_initiatives, assigns(:recent_initiatives)
  end

  test "should redirect authenticated user to initiatives path" do
    sign_in @user
    get root_url
    assert_redirected_to initiatives_path
  end

  private
  def sign_in(user)
    post user_session_url, params: { user: { email: user.email, password: 'password123' } }
    follow_redirect!
  end

end
