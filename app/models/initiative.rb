class Initiative < ApplicationRecord
  resourcify
  has_many :roles, class_name: "Role", as: :resource
  has_many :users, through: :roles, source: :users
  has_many :requests
  def self.all_roles
    Role.where(resource_type: 'Initiative')
  end

  validates :name, uniqueness: true,  presence: true
  validates :topic, presence: true
  validates :description, presence: true

  def get_admin
    roles.find_by(name: 'admin_initiative')&.users.first
  end

  def get_request(user)
    requests.where(user: user).last
  end

end
