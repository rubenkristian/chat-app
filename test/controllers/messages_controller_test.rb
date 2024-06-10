require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    room = RoomChat.create(name: "Hello", creator: "1234")
    message1 = Message.create(body: "Message 1", room_chat_id: room.id)
    message2 = Message.create(body: "Message 2", room_chat_id: room.id)
    get messages_url, params: { room_id: room.id }
    assert_response :success
  end
end
