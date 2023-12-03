FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    trait :buyer do
      first_name { "#{Faker::Name.first_name}-buyer" }
    end

    trait :owner do
      first_name { "#{Faker::Name.first_name}-owner" }
    end
  end
end
