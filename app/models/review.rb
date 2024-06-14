# Clase que representa una reseña hecha por un usuario a un evento.
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event
  validates :user,  presence: true
  validates :event, presence: true
end
