# app/channels/room_channel.rb
class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:id])
    stream_for room
  end

  def unsubscribed
  end
end
