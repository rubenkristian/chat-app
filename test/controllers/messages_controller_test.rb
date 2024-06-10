require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    room = RoomChat.create(name: "Hello", creator: "1234")
    Message.create(body: "Message 1", room_chat_id: room.id)
    Message.create(body: "Message 2", room_chat_id: room.id)
    get messages_url, params: { room_id: room.id }
    assert_response :success
  end

  test "should get response failed room chat not found" do
    RoomChat.create(name: "Hello", creator: "1234")
    get messages_url, params: { room_id: 0 }
    assert_response :not_found
  end

  test "should send message" do
    room = RoomChat.create(name: "Hello", creator: "1234")
    post '/messages/send', params: { message: { room_chat_id: room.id, from_id: '1234', from_name: 'test', body: 'hello' } }
    assert_response :created
  end

  test "shouldn't send message" do
    post '/messages/send', params: { message: { room_chat_id: 0, from_id: '1234', from_name: 'test', body: 'hello' } }
    assert_response :not_found
  end

end
