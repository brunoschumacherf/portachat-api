require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end

  describe 'callbacks' do
    it 'broadcasts a message after creation' do
      message = build(:message)
      expect(RoomChannel).to receive(:broadcast_to).with(message.room, any_args).once

      message.save!
    end
  end
end
