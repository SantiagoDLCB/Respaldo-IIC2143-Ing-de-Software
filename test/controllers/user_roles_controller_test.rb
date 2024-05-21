require 'test_helper'

class UserRolesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @user_role = user_roles(:one)
    @admin = users(:default_user)
    sign_in @admin
    @user = users(:another_user)
  end

  ### Seguir ###

end
