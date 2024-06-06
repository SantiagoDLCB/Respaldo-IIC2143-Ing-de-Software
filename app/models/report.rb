# Clase que representa un reporte hecho por un usuario a una iniciativa.
class Report < ApplicationRecord
  belongs_to :user
  belongs_to :initiative
  validates :user,  presence: true
  validates :initiative, presence: true
  validates :content, presence: true
  validates :reason, presence: true
end
