# frozen_string_literal: true

# Controlador que maneja el registro de usuarios, gestionado por Devise.
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create, :update]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # Configura los parametros permitidos para el registro de un usuario
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:name, :last_name, :avatar])
  end

  # Configura los parametros permitidos para la actualización de un usuario
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:name, :last_name, :avatar])
  end

  # Acción para buscar fotos en la API de Unsplash
  def search_photos
    if params[:query].present?
      @photos = Unsplash::Photo.search(params[:query], page = 1, per_page = 12)
    else
      @photos = []
    end
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
