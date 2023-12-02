class Business < ApplicationRecord

  belongs_to :owner, class_name: "User"
  has_many :buy_orders

  validates_presence_of :name, :shares_available

  validates :name, length: { minimum: 2 }
  validates_numericality_of :shares_available, greater_than_or_equal_to: 0
end
