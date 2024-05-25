require "test_helper"

class ReviewTest < ActiveSupport::TestCase

  setup do
    @user = users(:default_user)
    @event = events(:two)
    @review = reviews(:default_review)
  end

  test "should be valid with valid attributes 2" do
    assert @review.valid?
  end

  test "should be invalid without a user" do
    @review.user = nil
    assert_not @review.valid?
  end

  test "should be invalid without an event" do
    @review.event = nil
    assert_not @review.valid?
  end

  test "should belong to a user" do
    assert_equal @user, @review.user
  end

  test "should belong to an event" do
    assert_equal @event, @review.event
  end

end