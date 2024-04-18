class User < ApplicationRecord
  rolify
  after_create :assign_default_role

  def assign_default_role
    self.add_role(:normal_user) if self.roles.blank?
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, format: { with: /\A[^@\s]+@uc\.cl\z/, message: "debe ser un Mail UC" }
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true
  validates :last_name, presence: true
end
