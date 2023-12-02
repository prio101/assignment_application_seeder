class BuyOrder < ApplicationRecord
  belongs_to :business
  belongs_to :buyer, class_name: "User"

  enum status: { pending: 'pending', accept: 'accept', reject: 'reject' }
end
