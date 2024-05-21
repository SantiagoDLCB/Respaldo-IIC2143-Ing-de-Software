require "test_helper"

class InitiativeTest < ActiveSupport::TestCase

  setup do
    @initiative = initiatives(:one)
    @initiative2 = initiatives(:two)
  end

  test "should be valid with valid attributes" do
    assert @initiative.valid?
  end

  test "should be invalid without a name" do
    @initiative.name = nil
    assert_not @initiative.valid?
  end

  test "should be invalid without a topic" do
    @initiative.topic = nil
    assert_not @initiative.valid?
  end

  test "should be invalid without a description" do
    @initiative.description = nil
    assert_not @initiative.valid?
  end

  test "should be invalid with a duplicate name" do
    duplicate_initiative = @initiative.dup
    @initiative.save
    assert_not duplicate_initiative.valid?
  end

  test "should create roles after create" do
    new_initiative = Initiative.new(
      name: "New Initiative",
      topic: "New Topic",
      description: "New Description"
    )

    assert new_initiative.save, "Failed to save new initiative"

    assert new_initiative.roles.count == 2, "Expected initiative to have 2 roles after creation"
  end

  test "should create roles after create 2" do
    initiative = Initiative.create(name: 'New Initiative', topic: 'New Topic', description: 'New Description')
    assert_equal 2, initiative.roles.count
    assert initiative.roles.find_by(name: 'admin_initiative')
    assert initiative.roles.find_by(name: 'member')
  end

  test "should delete associated events before destroy" do
    assert_difference('Event.count', -1) do
      @initiative.destroy
    end
  end

  test "should delete associated roles before destroy" do
    assert_difference('Role.count', -@initiative.roles.count) do
      @initiative.destroy
    end
  end

  test "should delete associated requests before destroy" do
    assert_difference('Request.count', -2) do
      @initiative.destroy
    end
  end

  test "should delete associated messages before destroy" do
    assert_difference('Message.count', -1) do
      @initiative.destroy
    end
  end

  test "should delete associated reports before destroy" do
    assert_difference('Report.count', -1) do
      @initiative.destroy
    end
  end

  test "should return all admin users" do
    assert_equal @initiative.get_all_admins.count, @initiative.roles.where(name: 'admin_initiative').count
  end

  test "should return all members" do
    assert_equal @initiative.get_members.count, @initiative.roles.where(name: 'member').count
  end

  test "should return all events" do
    events = @initiative.get_events
    assert_equal @initiative.events.count, events.count
  end

  teardown do
    Rails.cache.clear
  end
  
end
