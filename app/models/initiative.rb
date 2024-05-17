class Initiative < ApplicationRecord
  resourcify
  has_many :roles, class_name: "Role", as: :resource, dependent: :delete_all
  has_many :users, through: :roles, source: :users
  has_many :requests, dependent: :delete_all
  has_many :events, dependent: :delete_all
  has_many :messages, dependent: :delete_all
  has_many :reports, dependent: :delete_all
  def self.all_roles
    Role.where(resource_type: 'Initiative')
  end

  validates :name, uniqueness: true,  presence: true
  validates :topic, presence: true
  validates :description, presence: true


  after_create :create_roles

  def get_admin
    roles.find_by(name: 'admin_initiative')&.users.first
  end

  def get_request(user)
    requests.where(user: user).last
  end


  def get_members
    roles.where(name: 'member', resource_type: 'Initiative').includes(:users).map(&:users).flatten.uniq
  end
  def get_events
    self.events
  end


  private
  def create_roles
    Role.create(name: :admin_initiative, resource: self)
    Role.create(name: :member, resource: self)
  end


end
