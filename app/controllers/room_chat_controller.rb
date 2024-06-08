class RoomChatController < ApplicationController
    def index
        @room_chat = RoomChat.order(updated_at: :desc).page(params[:page]).per(params[:size])
        render json: @room_chat
    end

    def show
        room = RoomChat.find(:room_id)

        if room
            render json: { status: 'found', message: 'room founded', data: room }, status: :success
        else
            render json: { status: 'not found', messag: 'room is not found'}, status: :not_found
        end
    end

    def add
        room = params.require(:name, :creator)
        @room_chat = RoomChat.new(room)

        if @room_chat.save
            render json: { status: 'success', message: 'room created', data: room }, status: :created
        else
            render json: { status: 'failed', message: 'room not created'}, status: :unprocessable_entity
        end
    end
end
