require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:default_user)
  end

  test "should redirect to initiatives path after sign in" do
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