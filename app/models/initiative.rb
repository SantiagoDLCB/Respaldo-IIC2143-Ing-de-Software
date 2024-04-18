class Initiative < ApplicationRecord
    resourcify
    has_many :roles, class_name: "Role", as: :resource
    has_many :users, through: :roles, source: :users
    def self.all_roles
        Role.where(resource_type: 'Initiative')
      end
    
    validates :name, uniqueness: true,  presence: true
    validates :topic, presence: true
    validates :description, presence: true
end
