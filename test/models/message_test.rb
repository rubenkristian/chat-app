require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "should not save message without without body" do
    room = RoomChat.create(name: "Hello", creator: "1234")
    message = Message.new
    message.from_id = '1234'
    message.from_name = 'Name'
    message.room_chat_id = room.id
    assert_not message.save
  end

  test "shoudn't save message without room chat id" do
    message = Message.new
    message.from_id = '1234'
    message.from_name = 'Name'
    message.body = 'test'
    assert_not message.save
  end

  test "shoud save message" do
    room = RoomChat.create(name: "Hello", creator: "1234")
    message = Message.new
    message.from_id = '1234'
    message.from_name = 'Name'
    message.body = 'test'
    message.room_chat_id = room.id
    assert message.save
  end
end
