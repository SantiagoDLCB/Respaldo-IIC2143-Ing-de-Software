class Initiative < ApplicationRecord
  resourcify
  before_destroy :delete_associated_events
  has_many :roles, class_name: "Role", as: :resource, dependent: :delete_all
  has_many :users, through: :roles, source: :users
  has_many :requests, dependent: :delete_all
  has_many :events , dependent: :delete_all
  has_many :messages, dependent: :delete_all
  has_many :reports, dependent: :delete_all
  has_one_attached :image

  def self.all_roles
    Role.where(resource_type: 'Initiative')
  end

  validates :name, uniqueness: true,  presence: true, length: { maximum: 20 }
  validates :topic, presence: true, length: { maximum: 30 }
  validates :description, presence: true


  after_create :create_roles


  def get_all_admins
    roles.where(name: 'admin_initiative', resource_type: 'Initiative').includes(:users).map(&:users).flatten.uniq
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
  def get_name
    self.name
  end


  private
  def create_roles
    Role.create(name: :admin_initiative, resource: self)
    Role.create(name: :member, resource: self)
  end

  def delete_associated_events
    self.events.destroy_all
  end



end
