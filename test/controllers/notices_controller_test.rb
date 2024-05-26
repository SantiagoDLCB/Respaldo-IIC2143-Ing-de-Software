require "test_helper"

class NoticesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
    @user = users(:default_user)
    @notice = notices(:one)
    sign_in @user
  end

  test "should get index" do
    get event_path(@notice.event)
    assert_response :success
  end

  test "should create notice" do
    assert_difference('Notice.count', 1) do
      post event_notices_path(@event), params: { title: "New Notice", content: "This is a new notice." }
    end
    assert_redirected_to event_url(@event)
    assert_equal 'Anuncio creado exitosamente.', flash[:notice]
  end

  test "should not create notice with invalid data" do
    assert_no_difference('Notice.count') do
      post event_notices_path(@event), params: { title: nil, content: "Invalid notice content." }
    end
    assert_redirected_to event_path(@event)
    assert_equal 'No se ha podido crear el anuncio. Intente nuevamente.', flash[:alert]
  end

end