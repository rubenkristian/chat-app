class MessagesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    room = RoomChat.find(params[:room_id])
    if room.nil?
      render json: { status: 'not found', message: 'Cannot find the room' }, status: 404
    end

    if params[:threshold_id]
      messages = Message.where(room_chat:room.id).where('id < ?', params[:threshold_id]).order(id: :desc).limit(params[:size]).all
    else
      messages = Message.where(room_chat:room.id).order(id: :desc).limit(params[:size]).all
    end

    render json: { data: messages, last: messages.size > 0 ? messages.last.id : nil }
  end

  def send_msg
    message_params = params.require(:message).permit(:from_id,:from_name,:body,:room_chat_id)
    room = RoomChat.find(message_params[:room_chat_id])
    if room.nil?
      render json: { status: 'failed', message: 'cannot find room'}, status: :unprocessable_entity
      return
    end

    new_message = Message.new(message_params)

    if new_message.save
      ActionCable.server.broadcast "chat_#{message_params[:room_chat_id]}", {id: new_message.id, body: new_message.body, from_name: new_message.from_name, from_id: new_message.from_id, created_at: new_message.created_at, updated_at: new_message.updated_at}
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
