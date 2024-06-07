class RoomChatController < ApplicationController
    def index
        @room_chat = RoomChat.page(params[:page]).per(10)
        render json: @room_chat
    end

    def add
        room = params.require(:name)
        @room_chat = RoomChat.new(room)

        if @room_chat.save
            render json: { status: 'success', message: 'room created', data: room }, status: :created
        else
            render json: { status: 'failed', message: 'room not created'}, status: :unprocessable_entity
        end
    end
end
