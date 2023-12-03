# == Schema Information
#
# Table name: businesses
#
#  id               :bigint           not null, primary key
#  name             :string
#  shares_available :decimal(10, 2)   default(0.0)
#  status           :string           default(NULL)
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
require 'rails_helper'

RSpec.describe Business, type: :model do
  let(:owner) { FactoryBot.create(:user, :owner) }
  let(:business) { FactoryBot.create(:business, owner: owner) }
  let(:invalid_business) { FactoryBot.build(:business, name: nil, owner: nil) }

  describe 'validations' do
    it 'should have a valid name' do
      expect(business.name).to_not be_nil
    end

    it 'should be valid with a owner' do
      expect(business).to be_valid
      expect(business.owner).to eq(owner)
    end

    it 'should not be valid without a name' do
      expect(invalid_business).to_not be_valid
    end

    it 'should have a valid owner' do
      expect(business.owner).to eq(owner)
    end

    it 'should not be valid without an owner' do
      expect(invalid_business).to_not be_valid
    end

    it 'name should be unique' do
      invalid_business.owner = owner
      invalid_business.name = business.name
      expect { invalid_business.save }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe 'associations' do
    it 'should belongs to an owner' do
      should belong_to(:owner)
    end
  end
end
