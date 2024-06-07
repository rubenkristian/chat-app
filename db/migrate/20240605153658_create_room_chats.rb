class CreateRoomChats < ActiveRecord::Migration[7.1]
  def change
    create_table :room_chats do |t|
      t.string :name

      t.timestamps
    end
  end
end
