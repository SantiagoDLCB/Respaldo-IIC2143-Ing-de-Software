require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @report = reports(:one)
    @user = users(:default_user)
    sign_in @user
  end


end