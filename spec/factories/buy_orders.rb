# == Schema Information
#
# Table name: buy_orders
#
#  id          :bigint           not null, primary key
#  price       :decimal(10, 2)   default(0.0)
#  quantity    :decimal(10, 2)   default(0.0)
#  status      :string           default("pending")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  business_id :bigint
#  buyer_id    :bigint
#
# Indexes
#
#  index_buy_orders_on_business_id  (business_id)
#  index_buy_orders_on_buyer_id     (buyer_id)
#
# Foreign Keys
#
#  fk_rails_...  (business_id => businesses.id)
#  fk_rails_...  (buyer_id => users.id)
#
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
