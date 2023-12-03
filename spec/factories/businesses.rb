# == Schema Information
#
# Table name: businesses
#
#  id               :bigint           not null, primary key
#  name             :string
#  shares_available :decimal(10, 2)   default(0.0)
#  status           :string           default("active")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  owner_id         :bigint
#
# Indexes
#
#  index_businesses_on_name      (name) UNIQUE
#  index_businesses_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
FactoryBot.define do
  factory :business do
    name { Faker::Company.name }
    shares_available { Faker::Number.between(from: 1, to: 100) }

    association :owner, factory: :user
  end
end
