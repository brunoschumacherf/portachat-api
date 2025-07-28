require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('not-an-email').for(:email) }
    it { should have_secure_password }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe 'enums' do
    it { should define_enum_for(:access_level).with_values(member: 0, admin: 1) }
    it { should define_enum_for(:status).with_values(active: 0, inactive: 1) }
  end

  describe 'associations' do
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:room_memberships).dependent(:destroy) }
    it { should have_many(:rooms).through(:room_memberships) }
  end
end
