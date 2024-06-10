class RoomChat < ApplicationRecord
    validates :name, presence: true
    validates :creator, presence: true
end
