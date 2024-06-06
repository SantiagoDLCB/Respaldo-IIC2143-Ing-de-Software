# frozen_string_literal: true

# Clase que contiene métodos auxiliares para los controladores
class ApplicationController < ActionController::Base

  # Retorna la ruta a la que se redirige al iniciar sesión
  def after_sign_in_path_for(*)
    initiatives_path
  end
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # Permite la edición de los parámetros de los usuarios
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    # Retorna la ruta a la que se redirige al cerrar sesión
    def after_sign_out_path_for(_resource_or_scope)
      after_sign_out_path
    end
  end
end
