require "test_helper"

class RequestTest < ActiveSupport::TestCase

  setup do
    @request = requests(:two)
    @user = users(:third_user)
    @initiative = initiatives(:one)
  end

  test "should be valid with valid attributes" do
    assert @request.valid?
  end

  test "should be invalid without a user" do
    @request.user = nil
    assert_not @request.valid?
  end

  test "should be invalid without an initiative" do
    @request.initiative = nil
    assert_not @request.valid?
  end

  test "should have the correct status enum values" do
    assert_equal 'Pendiente', Request.statuses[:pending]
    assert_equal 'Aceptada', Request.statuses[:accepted]
    assert_equal 'Rechazada', Request.statuses[:denied]
    assert_equal 'Cancelada', Request.statuses[:cancelled]
  end

  test "should add member role to user when status changes to accepted" do
    @request = Request.new(user: @user, initiative: @initiative, status: 'pending')
    @request.status = 'accepted'
    assert_difference '@user.roles.count', 1 do
      @request.save
    end
    assert @user.has_role?(:member, @initiative)
  end

  test "should not add member role to user when status changes to denied" do
    @request.status = 'denied'
    assert_no_difference '@user.roles.count' do
      @request.save
    end
    assert_not @user.has_role?(:member, @initiative)
  end

  test "should not add member role to user when status changes to cancelled" do
    @request.status = 'cancelled'
    assert_no_difference '@user.roles.count' do
      @request.save
    end
    assert_not @user.has_role?(:member, @initiative)
  end


end
