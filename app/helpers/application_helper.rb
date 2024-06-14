# frozen_string_literal: true

# Módulo que contiene métodos auxiliares para las vistas de la aplicación.
module ApplicationHelper
  # Retorna el nombre del rol en español
  # @param rol [String] el nombre del rol
  # @return [String] el nombre del rol en español
  def traducir_rol(rol)
    case rol
    when 'admin_initiative'
      'Administrador'
    when 'member'
      'Miembro'
    when 'admin_event'
      'Administrador'
    when 'attendant'
      'Participante'
    else
      rol.capitalize
    end
  end
end
