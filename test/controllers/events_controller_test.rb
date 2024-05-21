require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
    @user = users(:default_user)
    sign_in @user
  end

  test "should show event" do
    get "/events/#{@event.id}"
    assert_response :success
  end

  ### Seguir ###

end