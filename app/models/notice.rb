# app/models/notice.rb
class Notice < ApplicationRecord
  belongs_to :event
  validates :title,  presence: true
  validates :event, presence: true
end
