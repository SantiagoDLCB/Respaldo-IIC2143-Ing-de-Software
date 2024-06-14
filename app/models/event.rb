# Clase que representa un evento en el sistema, que pertenece a una iniciativa.
class Event < ApplicationRecord
  resourcify
  has_many :roles, class_name: "Role", as: :resource, dependent: :delete_all
  has_many :users, through: :roles, source: :users
  has_many :reviews, dependent: :delete_all
  has_many :notices, dependent: :delete_all
  belongs_to :initiative
  before_destroy :delete_associated_reviews
  before_destroy :delete_associated_notices

  # Retorna todos los roles de eventos
  def self.all_roles
    Role.where(resource_type: 'Event')
  end

  validates :name,  presence: true, length: { maximum: 20 }
  validates :description, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  
  # Retorna true si el evento esta activo, false en caso contrario
  def is_active?
    if self.capacity != 0
      return true
    else
      return false
    end
  end

  # Retorna los asistentes del evento
  def get_attendants
    roles.where(name: 'attendant', resource_type: 'Event').includes(:users).map(&:users).flatten.uniq
  end

  # Retorna la iniciativa del evento
  def get_iniative
    self.initiative
  end

  # Retorna true si el evento tiene cupo disponible, false en caso contrario
  #
  # @param capacity [Integer] la capacidad del evento
  # @return [Boolean]
  def modify_capacity(capacity)
    if capacity >= self.get_attendants.count or capacity == 0
      return true
    else
      return false
    end
  end

  after_create :create_roles

  private
  # Crea los roles de evento
  def create_roles
    Role.create(name: :attendant, resource: self)
  end

  # Elimina los reviews asociados al evento
  def delete_associated_reviews
    self.reviews.destroy_all
  end

  # Elimina los anuncios asociados al evento
  def delete_associated_notices
    self.notices.destroy_all
  end

end
