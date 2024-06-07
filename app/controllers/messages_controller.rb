class MessagesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    room = RoomChat.find(params[:room_id])
    if room.nil?
      render json: { status: 'not found', message: 'Cannot find the room' }, status: 404
    end
    messages = Message.where(room_chat:room.id).page(params[:page]).per(10)
    render json: { data: messages, current_page: messages.current_page, total_pages: messages.total_pages, total_count: messages.total_count }
  end

  def send_msg
    message_params = params.require(:message).permit(:from_id,:from_name,:body,:room_chat_id)
    room = RoomChat.find(message_params[:room_chat_id])
    print 'hai'
    print message_params[:room_chat_id]
    if room.nil?
      render json: { status: 'failed', message: 'cannot find room'}, status: :unprocessable_entity
      return
    end

    new_message = Message.new(message_params)

    if new_message.save
      render json: { status: 'success', message: 'success send message', data: new_message }, status: :created
    else
      render json: { status: 'failed', message: 'failed to send message' }, status: :unprocessable_entity
    end
  end
  
    # Define a method to handle RecordNotFound exceptions
  def record_not_found(error)
    render json: { status: 'failed', message: error.message }, status: :not_found
  end
end
