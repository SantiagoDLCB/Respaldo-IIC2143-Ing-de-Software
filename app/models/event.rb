class Event < ApplicationRecord
  resourcify
  has_many :roles, class_name: "Role", as: :resource, dependent: :delete_all
  has_many :users, through: :roles, source: :users
  belongs_to :initiative
  has_many :reviews, dependent: :delete_all
  before_destroy :delete_associated_reviews
  def self.all_roles
    Role.where(resource_type: 'Event')
  end

  validates :name,  presence: true
  validates :description, presence: true
  validates :capacity, presence: true

  def get_admin
    roles.find_by(name: 'admin_event')&.users.first
  end

  def get_attendants
    roles.where(name: 'attendant', resource_type: 'Event').includes(:users).map(&:users).flatten.uniq
  end


end
