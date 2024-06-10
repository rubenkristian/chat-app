require "test_helper"

class RoomChatControllerTest < ActionDispatch::IntegrationTest
  test "get respons room chat" do
    room = RoomChat.create(name: "Hello", creator: "1234")
    get room_chat_path(room.id)
    assert_response :success
  end

  test "get respons not found room chat" do
    RoomChat.create(name: "Hello", creator: "1234")
    get room_chat_path(0)
    assert_response :not_found
  end

  test "create new room chat" do
    post '/room_chat/add', params: {name: 'test', creator: '1234'}
    assert_response :created
  end

  test "create new room chat fail" do
    post '/room_chat/add', params: {name: nil, creator: '1234'}
    assert_response :unprocessable_entity
  end

  test "get list room chat" do
    room1 = RoomChat.create(name: "Hello1", creator: "1234")
    room2 = RoomChat.create(name: "Hello2", creator: "1234")

    get '/room_chat', params: { page: 1, size: 20 }
    json_response = JSON.parse(response.body)
    assert_equal room1.name, json_response['data'][1]['name']
    assert_equal room2.name, json_response['data'][0]['name']
    assert_equal 1, json_response['current_page']
    assert_response :ok
  end
end
