class Message < ApplicationRecord
  validates :from_id, presence: true
  validates :from_name, presence: true
  validates :body, presence: true
  belongs_to :room_chat
end
