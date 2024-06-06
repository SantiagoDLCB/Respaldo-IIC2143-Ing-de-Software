# Clase que representa un anuncio, y que pertenece a un evento.
class Notice < ApplicationRecord
  belongs_to :event
  validates :title,  presence: true
  validates :event, presence: true
  validates :content, presence: true, length: { minimum: 1, maximum: 200 }
end
