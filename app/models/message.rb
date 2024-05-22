class Message < ApplicationRecord
  belongs_to :user
  belongs_to :initiative
  validates :user,  presence: true
  validates :initiative, presence: true
  after_create_commit { broadcast_append_to self.initiative }



end
