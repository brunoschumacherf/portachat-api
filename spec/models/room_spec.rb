require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { build(:room) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:room_memberships).dependent(:destroy) }
    it { should have_many(:users).through(:room_memberships) }
  end
end
