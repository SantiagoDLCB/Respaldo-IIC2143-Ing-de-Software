# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def after_sign_in_path_for(*)
    initiatives_path
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    def after_sign_out_path_for(resource_or_scope)
      after_sign_out_path
    end
  end
end
