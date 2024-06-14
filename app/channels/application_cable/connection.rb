# frozen_string_literal: true

# Clase abstracta de la que heredan todas las conexiones
module ApplicationCable

  # Clase que representa una conexión de ActionCable
  class Connection < ActionCable::Connection::Base
  end
end
