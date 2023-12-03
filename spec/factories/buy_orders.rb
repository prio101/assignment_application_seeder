FactoryBot.define do
  factory :buy_order do
    quantity { Faker::Number.between(from: 1, to: 50) }
    price { Faker::Number.between(from: 1, to: 100) }
    status { ['pending', 'accepted', 'rejected'].sample }
    association :business, factory: :business
    association :buyer, factory: :user

    trait :pending do
      status { 'pending' }
    end

    trait :accepted do
      status { 'accepted' }
    end

    trait :rejected do
      status { 'rejected' }
    end
  end
end
