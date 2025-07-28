# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true

  after_create_commit { broadcast_append_to self.room }

  private

  
  # def broadcast_message
  #  RoomChannel.broadcast_to(self.room, self)
  # end
end
