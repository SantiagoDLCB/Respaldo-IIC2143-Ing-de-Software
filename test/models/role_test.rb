require "test_helper"

class RoleTest < ActiveSupport::TestCase
  
  setup do
    @role = roles(:one)
    @role2 = roles(:two)
    @user = users(:default_user)
    @initiative = initiatives(:one)
  end

  test "should be valid with valid attributes" do
    assert @role.valid?
  end

  test "should have users association" do
    assert_respond_to @role, :users
  end

  test "should have resource association" do
    assert_respond_to @role, :resource
  end

  test "should allow valid resource_type" do
    @role.resource_type = 'Initiative'
    assert @role.valid?
  end

  test "should not allow invalid resource_type" do
    @role.resource_type = 'InvalidType'
    assert_not @role.valid?
  end

  test "should allow nil resource_type" do
    @role.resource_type = nil
    assert @role.valid?
  end

  test "should have users through users_roles join table" do
    assert_difference '@role.users.count', 1 do
      @role.users << @user
    end
  end

  test "should belong to a polymorphic resource" do
    @role.resource = @initiative
    assert @role.valid?
    assert_equal @initiative, @role.resource
  end

  test "should be deletable" do
    assert_difference 'Role.count', -1 do
      @role.destroy
    end
  end

  test "should validate inclusion of resource_type in Rolify.resource_types" do
    valid_resource_type = Rolify.resource_types.first
    @role.resource_type = valid_resource_type
    assert @role.valid?

    invalid_resource_type = 'InvalidResourceType'
    @role.resource_type = invalid_resource_type
    assert_not @role.valid?
  end

  teardown do
    Rails.cache.clear
  end

end
