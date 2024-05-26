require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @message = messages(:default_message)
    @initiative = initiatives(:one)
    @user = users(:default_user)
    sign_in @user
  end

  test "should create message" do
    assert_difference('Message.count', 1) do
      post initiative_messages_path(@initiative), params: { message: { content: "New message content" } }
    end
    assert_response :success
  end

  test "should not create message without content" do
    assert_no_difference('Message.count') do
      post initiative_messages_path(@initiative), params: { message: { content: "" } }
    end
    assert_response :success
  end
  
end