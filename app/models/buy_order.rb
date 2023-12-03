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
class BuyOrder < ApplicationRecord
  belongs_to :business
  belongs_to :buyer, class_name: "User"

  validates :quantity, :price, :status, presence: true

  enum status: { pending: 'pending', accepted: 'accept', rejected: 'rejected' }

  def self.serialized_response(buy_orders)
    
  end
end
