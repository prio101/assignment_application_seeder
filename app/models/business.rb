# == Schema Information
#
# Table name: businesses
#
#  id               :bigint           not null, primary key
#  name             :string
#  shares_available :decimal(10, 2)   default(0.0)
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
class Business < ApplicationRecord

  belongs_to :owner, class_name: "User"
  has_many :buy_orders

  validates_presence_of :name, :shares_available

  validates :name, length: { minimum: 2 }
  validates_numericality_of :shares_available, greater_than_or_equal_to: 0
end
