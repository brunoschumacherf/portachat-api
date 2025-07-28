FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'password123' }
    access_level { :member }
    status { :active }

    trait :admin do
      access_level { :admin }
    end

    trait :inactive do
      status { :inactive }
    end
  end
end
