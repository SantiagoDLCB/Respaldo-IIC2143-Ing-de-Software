require "test_helper"

class ReportTest < ActiveSupport::TestCase

  setup do
    @user = users(:another_user)
    @initiative = initiatives(:one)
    @report = reports(:one)
  end

  test "should be valid with valid attributes" do
    assert @report.valid?
  end

  test "should be invalid without a user" do
    @report.user = nil
    assert_not @report.valid?
  end

  test "should be invalid without an initiative" do
    @report.initiative = nil
    assert_not @report.valid?
  end

  test "should be invalid without content" do
    @report.content = nil
    assert_not @report.valid?
  end

  test "should be invalid without a reason" do
    @report.reason = nil
    assert_not @report.valid?
  end

  test "should belong to a user" do
    assert_equal @user, @report.user
  end

  test "should belong to an initiative" do
    assert_equal @initiative, @report.initiative
  end
  
end