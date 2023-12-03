# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:invalid_user) { FactoryBot.build(:user, email: nil, password: 'password') }

  describe 'validations' do
    it 'should be valid with a email and a password' do
      expect(user).to be_valid
      expect(user.email).to_not be_nil
      expect(user.password).to_not be_nil
    end

    it 'should not be valid without a email' do
      invalid_user.password = nil
      expect(invalid_user).to_not be_valid
    end

    it 'email should be unique' do
      invalid_user.email = user.email

      expect { invalid_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
