require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    @message = messages(:default_message)
    @user = users(:default_user)
    sign_in @user
  end
  
  ### Seguir ###
    
end