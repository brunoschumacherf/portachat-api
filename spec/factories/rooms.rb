FactoryBot.define do
  factory :room do
    name { "Sala #{Faker::Lorem.word.capitalize}" }
  end
end
