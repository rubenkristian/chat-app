require "test_helper"

class RoomChatTest < ActiveSupport::TestCase
  test "create room chat" do
    room_chat = RoomChat.new
    room_chat.name = 'test'
    room_chat.creator = '1234'
    assert room_chat.save
  end

  test "shouldn't create room chat wihtout creator room" do
    room_chat = RoomChat.new
    room_chat.name = 'test'
    assert_not room_chat.save
  end

  test "shouldn't create room chat without name room" do
    room_chat = RoomChat.new
    room_chat.creator = '1234'
    assert_not room_chat.save
  end
end
