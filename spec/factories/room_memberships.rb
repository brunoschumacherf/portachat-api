FactoryBot.define do
  factory :room_membership do
    association :user
    association :room
  end
end
