require "test_helper"

class EventTest < ActiveSupport::TestCase
  
  setup do
    @event = events(:one)
    @event2 = events(:two)
  end

  test "should be valid with valid attributes" do
    assert @event.valid?
  end

  test "should be invalid without a name" do
    @event.name = nil
    assert_not @event.valid?
  end

  test "should be invalid without a description" do
    @event.description = nil
    assert_not @event.valid?
  end

  test "should be invalid without an initiative" do
    @event.initiative = nil
    assert_not @event.valid?
  end

  test "should be invalid without a capacity" do
    @event.capacity = nil
    assert_not @event.valid?
  end

  test "should be invalid with a non-numeric capacity" do
    @event.capacity = "a"
    assert_not @event.valid?
  end
  
  test "should be invalid with a negative capacity" do
    @event.capacity = -1
    assert_not @event.valid?
  end

  test "should delete associated reviews before destroy" do
    assert_difference('Review.count', -@event.reviews.count) do
      @event.destroy
    end
  end

  test "should delete associated roles before destroy" do
    assert_difference('Role.count', -@event.roles.count) do
      @event.destroy
    end
  end

  test "should create roles after create" do
    event = Event.create(name: 'New Event', description: 'New Description', capacity: 20, initiative: initiatives(:one))
    assert_equal 1, event.roles.count
    assert event.roles.find_by(name: 'attendant')
  end

  test "should get attendants" do
    assert_equal @event.get_attendants.count, @event.roles.where(name: 'attendant').count
  end

  test "should modify capacity" do
    assert @event.modify_capacity(10)
  end

  teardown do
    Rails.cache.clear
  end
  
end
