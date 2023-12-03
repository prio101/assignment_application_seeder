FactoryBot.define do
  factory :business do
    name { Faker::Company.name }
    shares_available { Faker::Number.between(from: 1, to: 100) }

    association :owner, factory: :user
  end
end
