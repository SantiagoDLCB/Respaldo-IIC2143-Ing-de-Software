require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
    @user = users(:default_user)
    @normal_user = users(:another_user)
    @user.add_role(:admin_initiative, @event.initiative)
    sign_in @user
  end

  test "should show event path" do
    get event_path(@event)
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_path, params: { initiative: @event.initiative.id, name: "Test Event", description: "Test Description", capacity: 50 }
    end
    assert_redirected_to event_path(Event.last)
  end

  test "should not create event with invalid data" do
    assert_no_difference 'Event.count' do
      post events_path, params: { initiative: @event.initiative.id, name: "", description: "New Description 2", capacity: 50 }
    end
    assert_redirected_to root_path
  end

  test "should update event" do
    patch event_path(@event), params: { event: { initiative: @event.initiative.id, name: @event.name, description: @event.description, capacity: 100, update_type: 'data' } }, xhr: true
    assert_redirected_to event_path(@event)

    @event.reload
    assert_equal 100, @event.capacity
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_path(@event)
    end
    assert_redirected_to initiative_path(@event.initiative)
  end

  test "should not destroy event if user is not admin" do
    @normal_user.add_role(:attendant, @event)
    sign_in @normal_user
    assert_no_difference('Event.count') do
      delete event_path(@event)
    end
    assert_redirected_to root_path
  end

  test "should redirect create when not logged in" do
    sign_out @user
    assert_no_difference 'Event.count' do
      post events_path, params: { initiative: @event.initiative.id, name: "Test Event", description: "Test Description", capacity: 50 }
    end
    assert_redirected_to new_user_session_path
  end

  test "should join event" do
    sign_in @normal_user
    assert_difference('@event.get_attendants.count') do
      post add_user_role_event_path(@event)
    end
    assert_redirected_to event_path(@event)
    @normal_user.reload
    assert @normal_user.has_role?(:attendant, @event)
  end

  test "should leave event" do
    @normal_user.add_role(:attendant, @event)
    sign_in @normal_user
    assert_difference('@event.get_attendants.count', -1) do
      delete remove_user_role_event_path(@event)
    end
    assert_redirected_to event_path(@event)
    @normal_user.reload
    assert_not @normal_user.has_role?(:attendant, @event)
  end

  test "should remove attendant role from user" do
    @normal_user.add_role(:attendant, @event)
    patch event_path(@event), params: { event: { update_type: 'remove_attendant', user_id: @normal_user.id } }
    # assert_redirected_to event_path(@event)

    @normal_user.reload
    assert_not @normal_user.has_role?(:attendant, @event)
  end


end
