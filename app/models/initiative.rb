class Initiative < ApplicationRecord
  resourcify
  before_destroy :delete_associated_events
  has_many :roles, class_name: "Role", as: :resource, dependent: :delete_all
  has_many :users, through: :roles, source: :users
  has_many :requests, dependent: :delete_all
  has_many :events , dependent: :delete_all
  has_many :messages, dependent: :delete_all
  has_many :reports, dependent: :delete_all
  mount_uploader :image, ImageUploader

  # Retorna todos los roles de iniciativa
  def self.all_roles
    Role.where(resource_type: 'Initiative')
  end

  validates :name, uniqueness: true,  presence: true, length: { maximum: 20 }
  validates :topic, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validate :image_size

  after_create :create_roles

  # Retorna todos los administradores de la iniciativa
  def get_all_admins
    roles.where(name: 'admin_initiative', resource_type: 'Initiative').includes(:users).map(&:users).flatten.uniq
  end

  # Retorna todas las solicitudes a la iniciativa
  def get_request(user)
    requests.where(user: user).last
  end

  # Retorna todos los miembros de la iniciativa
  def get_members
    roles.where(name: 'member', resource_type: 'Initiative').includes(:users).map(&:users).flatten.uniq
  end

  # Retorna todos los eventos de la iniciativa
  def get_events
    self.events
  end

  # Retorna el nombre de la iniciativa
  def get_name
    self.name
  end

  private
  # Crea los roles de iniciativa
  def create_roles
    Role.create(name: :admin_initiative, resource: self)
    Role.create(name: :member, resource: self)
  end

  # Elimina los eventos asociados a la iniciativa
  def delete_associated_events
    self.events.destroy_all
  end

  # Validación de tamaño de la imagen
  def image_size
    if image.size > 10.megabytes
      errors.add(:image, "debe ser menor a 10MB")
    end
  end
end
