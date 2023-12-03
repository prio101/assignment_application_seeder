class BuyOrder < ApplicationRecord
  belongs_to :business
  belongs_to :buyer, class_name: "User"

  enum status: { pending: 'pending', accepted: 'accept', rejected: 'rejected' }
end
