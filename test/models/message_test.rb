require "test_helper"

class MessageTest < ActiveSupport::TestCase

  setup do
    @user = users(:default_user)
    @initiative = initiatives(:one)
    @message = messages(:default_message)
  end

  test "should be valid with valid attributes" do
    assert @message.valid?
  end

  test "should be invalid without a user" do
    @message.user = nil
    assert_not @message.valid?
    assert_includes @message.errors[:user], "no puede estar en blanco"
  end

  test "should be invalid without an initiative" do
    @message.initiative = nil
    assert_not @message.valid?
    assert_includes @message.errors[:initiative], "no puede estar en blanco"
  end

  test "should be invalid without content" do
    @message.content = nil
    assert_not @message.valid?
    assert_includes @message.errors[:content], "no puede estar en blanco"
  end

  test "should be invalid with content too short" do
    @message.content = ""
    assert_not @message.valid?
  end

  test "should be invalid with content too long" do
    @message.content = "a" * 501
    assert_not @message.valid?
  end

  test "should belong to a user" do
    assert_equal @user, @message.user
  end

  test "should belong to an initiative" do
    assert_equal @initiative, @message.initiative
  end

end
