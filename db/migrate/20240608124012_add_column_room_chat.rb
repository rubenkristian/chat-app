class AddColumnRoomChat < ActiveRecord::Migration[7.1]
  def change
    add_column :room_chats, :creator, :string
  end
end
