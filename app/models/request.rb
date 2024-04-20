class Request < ApplicationRecord
  belongs_to :user
  belongs_to :initiative
  enum status: { pending: 'Pendiente', accepted: 'Aceptada', denied: 'Rechazada', :cancelled => 'Cancelada'}
end
