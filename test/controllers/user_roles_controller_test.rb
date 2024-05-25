
require "test_helper"

class UserRolesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @admin = users(:default_user)
    @user = users(:another_user)
    @role_to_remove = roles(:three)
    sign_in @admin
  end

  # Tests

end
