# frozen_string_literal: true

# Clase abstracta de la que heredan todos los modelos
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
