# frozen_string_literal: true

# Controlador que maneja la lógica de la landing page.
class RenderController < ApplicationController
  before_action :redirect_to_initiatives, if: :user_signed_in?

  # Retorna las tres iniciativas más recientes
  def index
    @recent_initiatives = Initiative.order(created_at: :desc).limit(3)
  end

  private
  # Redirige a la vista de iniciativas
  def redirect_to_initiatives
    redirect_to initiatives_path
  end
end
