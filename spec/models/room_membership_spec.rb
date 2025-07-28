require 'rails_helper'

RSpec.describe RoomMembership, type: :model do
  subject { build(:room_membership) }

  describe 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:room_id) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:room) }
  end
end
