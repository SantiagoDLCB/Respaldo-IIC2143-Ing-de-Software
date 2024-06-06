# Clase que representa un mensaje en el sistema, que pertenece a una iniciativa y a un usuario.
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :initiative
  validates :user,  presence: true
  validates :initiative, presence: true
  validates :content, presence: true, length: { minimum: 1, maximum: 500 }
  after_create_commit { broadcast_append_to self.initiative }
end
