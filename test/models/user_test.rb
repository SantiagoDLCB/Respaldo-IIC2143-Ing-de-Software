require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:default_user)
    @user2 = users(:another_user)
  end

  test "should be valid with valid attributes" do
    assert @user.valid?
  end

  test "should be invalid without an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should be invalid without a username" do
    @user.username = nil
    assert_not @user.valid?
  end

  test "should be invalid without a name" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "should be invalid without a last name" do
    @user.last_name = nil
    assert_not @user.valid?
  end

  test "should be invalid with a non-UC email" do
    @user.email = "test@example.com"
    assert_not @user.valid?
  end

  test "should be invalid with a duplicate username" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should assign default role after create" do
    # Crear un nuevo usuario sin roles asignados
    new_user = User.new(
      email: "thirduser@uc.cl",
      username: "fourthuser",
      name: "New",
      last_name: "User",
      password: "password123"
    )
  
    # Intentar guardar el nuevo usuario
    assert new_user.save, "Failed to save new user: #{new_user.errors.full_messages.join(", ")}"
  
    # Verificar que el rol predeterminado se asigna correctamente
    assert new_user.has_role?(:normal_user), "Expected user to have the :normal_user role after creation"
  end

  test "should delete associated messages before destroy" do
    assert_difference 'Message.count', -1 do
      @user.destroy
    end
  end

  test "should delete associated reports before destroy" do
    assert_difference 'Report.count', -1 do
      @user2.destroy
    end
  end

  test "should delete associated reviews before destroy" do
    assert_difference 'Review.count', -1 do
      @user.destroy
    end
  end
  
  test "should delete associated requests before destroy" do
    assert_difference 'Request.count', -@user.requests.count do
      @user.destroy
    end
  end

  test "should delete associated initiatives and events before destroy" do
    assert_difference ['Initiative.count', 'Event.count'], -@user.initiatives.count do
      @user.destroy
    end
  end

  test "should delete associated roles before destroy" do
    assert_difference 'Role.count', -@user.roles.count do
      @user.destroy
    end
  end

  teardown do
    Rails.cache.clear
  end

end