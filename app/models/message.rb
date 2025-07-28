class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :content, presence: true

  after_create_commit :broadcast_message

  private

  def broadcast_message
    payload = self.as_json(include: { user: { only: [:id, :name] } })
    RoomChannel.broadcast_to(self.room, payload)
  end
end
