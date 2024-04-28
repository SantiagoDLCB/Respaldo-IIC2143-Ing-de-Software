class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  before_destroy :delete_associated_resources
  before_destroy :delete_associated_requests

  def delete_associated_resources
    self.initiatives.each do |initiative|
      if self.has_role?(:admin_initiative, initiative)
        initiative.destroy
      elsif self.has_role?(:member, initiative)
        self.remove_role(:member, initiative)
      end
    end

    self.events.each do |event|
      if self.has_role?(:admin, event)
        event.destroy
      elsif self.has_role?(:attendant, event)
        self.remove_role(:attendant, event)
      end
    end
  end

  def delete_associated_requests
    self.requests.destroy_all
  end

  def assign_default_role
    self.add_role(:normal_user) if self.roles.blank?
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #has_and_belongs_to_many :roles, :join_table => :users_roles
  has_many :initiatives, through: :roles, source: :resource, source_type: 'Initiative'
  has_many :events, through: :roles, source: :resource, source_type: 'Event'
  has_many :requests

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, format: { with: /\A[^@\s]+@uc\.cl\z/, message: "debe ser un Mail UC" }
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :last_name, presence: true
end
