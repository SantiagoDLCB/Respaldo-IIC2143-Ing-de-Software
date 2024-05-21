require 'test_helper'

class InitiativesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @initiative = initiatives(:one)
    @user = users(:default_user)
    sign_in @user
  end

  test "should get index" do
    get "/initiatives"
    assert_response :success
  end

  test "should show initiative" do
    get "/initiatives/#{@initiative.id}"
    assert_response :success
  end

  ### Seguir con los tests ###


end