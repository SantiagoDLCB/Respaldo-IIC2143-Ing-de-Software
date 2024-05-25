class Message < ApplicationRecord
  belongs_to :user
  belongs_to :initiative
  validates :user,  presence: true
  validates :initiative, presence: true
  validates :content, presence: true, length: { minimum: 1, maximum: 500 }
  after_create_commit { broadcast_append_to self.initiative }



end
