require "test_helper"

class NoticeTest < ActiveSupport::TestCase

  setup do
    @event = events(:one)
    @notice = notices(:one)
  end

  test "should be valid with valid attributes" do
    assert @notice.valid?
  end

  test "should be invalid without a title" do
    @notice.title = nil
    assert_not @notice.valid?
  end

  test "should be invalid without content" do
    @notice.content = nil
    assert_not @notice.valid?
  end

  test "should be invalid without an event" do
    @notice.event = nil
    assert_not @notice.valid?
  end

  test "should be invalid if content is too short" do
    @notice.content = ""
    assert_not @notice.valid?
  end

  test "should be invalid if content is too long" do
    @notice.content = "a" * 201
    assert_not @notice.valid?
  end

  test "should belong to an event" do
    assert_equal @event, @notice.event
  end

end