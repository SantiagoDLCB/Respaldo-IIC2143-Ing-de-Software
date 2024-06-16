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
    if params[:avatar] && params[:avatar].size > 10.megabytes
      flash[:alert] = "El tamaño de la imagen del avatar debe ser menor a 10MB."
      redirect_to new_user_registration_path
    end
  end

  # Configura los parametros permitidos para la actualización de un usuario
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:name, :last_name, :avatar])
    if params[:avatar] && params[:avatar].size > 10.megabytes
      flash[:alert] = "El tamaño de la imagen del avatar debe ser menor a 10MB."
      redirect_to new_user_registration_path
    end
  end

  # Acción para buscar fotos en la API de Unsplash
  def search_photos
    if params[:query].present?
      @photos = Unsplash::Photo.search(params[:query], 1, 20)
    else
      @photos = []
    end
  end

  require 'open-uri'
  def update_image
    @user = current_user
    nueva = { image: params[:image] }
    nueva[:image] = URI.open(nueva[:image])
    begin
      # Descargar la imagen desde el enlace proporcionado
      downloaded_image = URI.open(params[:image])

      # Crear un archivo temporal con la imagen descargada
      temp_file = Tempfile.new(['downloaded_image', '.jpg'])
      temp_file.binmode
      temp_file.write(downloaded_image.read)
      temp_file.rewind
      @user.avatar = temp_file

      if @user.save
        redirect_to edit_user_registration_path, notice: 'Avatar actualizado exitosamente.'
      else
        redirect_to edit_user_registration_path, alert: 'Hubo un problema al actualizar el avatar.'
      end
    rescue => e
      redirect_to edit_user_registration_path, alert: "Error al descargar el avatar #{e.message}"
    ensure
      temp_file.close
      temp_file.unlink if temp_file
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
