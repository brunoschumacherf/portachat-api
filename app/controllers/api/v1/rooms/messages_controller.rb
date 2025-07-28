module Api
  module V1
    module Rooms
      class MessagesController < ApplicationController
        before_action :set_room

        def index
          @messages = @room.messages.order(created_at: :asc)
          render json: @messages, include: { user: { only: [:id, :name] } }
        end

        def create
          @message = @room.messages.build(message_params)
          @message.user = current_user

          if @message.save
            render json: @message, include: { user: { only: [:id, :name] } }, status: :created
          else
            render json: @message.errors, status: :unprocessable_entity
          end
        end

        private

        def set_room
          @room = Room.find(params[:room_id])
        end

        def message_params
          params.require(:message).permit(:content)
        end
      end
    end
  end
end
