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
require 'rails_helper'

RSpec.describe BuyOrder, type: :model do
  let(:buyer) { FactoryBot.create(:user, :buyer) }
  let(:owner) { FactoryBot.create(:user, :owner) }
  let(:business) { FactoryBot.create(:business, owner: owner) }
  let(:buy_order) { FactoryBot.create(:buy_order, buyer: buyer, business: business, quantity: 2) }

  describe 'validations' do
    it 'should be valid with a buyer and a business' do
      expect(buy_order).to be_valid
      expect(buy_order.buyer).to eq(buyer)
      expect(buy_order.business).to eq(business)
    end

    it 'should not be valid without a buyer' do
      buy_order.buyer = nil
      expect(buy_order).to_not be_valid
    end

    it 'should not be valid without a business' do
      buy_order.business = nil
      expect(buy_order).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should belongs to a buyer' do
      should belong_to(:buyer)
    end

    it 'should belongs to a business' do
      should belong_to(:business)
    end
  end

  describe '#update_shares_available' do
    let(:initial_shares_available) { 100.0 }
    it 'should update shares available for business' do
      business.shares_available = initial_shares_available
      business.save
      business.reload
      expect(business.shares_available).to eq(initial_shares_available.to_d)
      buy_order.update_shares_available
      expect(business.shares_available.to_s).to eq((initial_shares_available - buy_order.quantity).to_s)
    end
  end
end
