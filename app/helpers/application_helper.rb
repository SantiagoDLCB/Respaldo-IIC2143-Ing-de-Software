# frozen_string_literal: true

module ApplicationHelper
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
