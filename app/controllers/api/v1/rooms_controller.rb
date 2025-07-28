# app/controllers/api/v1/rooms_controller.rb
module Api
  module V1
    class RoomsController < ApplicationController
      # GET /api/v1/rooms
      def index
        @rooms = Room.order(name: :asc)
        render json: @rooms
      end

      # POST /api/v1/rooms
      def create
        @room = Room.new(room_params)
        if @room.save
          @room.users << current_user
          render json: @room, status: :created
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end

      private

      def room_params
        params.require(:room).permit(:name)
      end
    end
  end
end
