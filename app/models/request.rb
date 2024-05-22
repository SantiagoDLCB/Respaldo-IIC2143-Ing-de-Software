class Request < ApplicationRecord
  belongs_to :user
  belongs_to :initiative
  enum status: { pending: 'Pendiente', accepted: 'Aceptada', denied: 'Rechazada', :cancelled => 'Cancelada'}
  before_save :check_status_accepted , if: :will_save_change_to_status?

  private

  def check_status_accepted
    # puts status_change_to_be_saved
    if status_change_to_be_saved[1] == 'accepted'
      self.user.add_role(:member, self.initiative)
    end
  end
end
