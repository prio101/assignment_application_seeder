class Business < ApplicationRecord
  validates_presence_of :name, :shares_available

  validates :name, length: { minimum: 2 }
  validates_numericality_of :shares_available, greater_than_or_equal_to: 0
end
