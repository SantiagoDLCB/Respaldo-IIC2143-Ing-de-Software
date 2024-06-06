class Report < ApplicationRecord
  belongs_to :user
  belongs_to :initiative
  validates :user,  presence: true
  validates :initiative, presence: true
  validates :content, presence: true
  validates :reason, presence: true
  belongs_to :user
  belongs_to :initiative

  enum status: { pending: 'Pendiente', accepted: 'Aceptada', denied: 'Rechazada' }

  validates :status, presence: true, inclusion: { in: statuses.keys }

  def status_text
    self.class.statuses.key(self.status)
  end
end
