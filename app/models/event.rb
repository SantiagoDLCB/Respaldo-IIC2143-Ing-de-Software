class Event < ApplicationRecord
  resourcify
  has_many :roles, class_name: "Role", as: :resource, dependent: :delete_all
  has_many :users, through: :roles, source: :users
  belongs_to :initiative
  has_many :reviews, dependent: :delete_all
  def self.all_roles
    Role.where(resource_type: 'Event')
  end

  validates :name,  presence: true
  validates :description, presence: true
  validates :capacity, presence: true


  def get_attendants
    roles.where(name: 'attendant', resource_type: 'Event').includes(:users).map(&:users).flatten.uniq
  end
  def modify_capacity(capacity)
    if capacity >= self.get_attendants.count
      return true
    else
      return false
    end
  end

  after_create :create_roles

  private
  def create_roles
    Role.create(name: :attendant, resource: self)
  end

end
