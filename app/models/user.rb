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
class User < ApplicationRecord

  has_secure_password


  has_many :businesses, foreign_key: :owner_id
  has_many :buy_orders, foreign_key: :buyer_id

  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :email, length: { minimum: 5 }
  validates :password, length: { minimum: 6 }

  validates_presence_of :email, :password
  validates_uniqueness_of :email

  def name
    "#{first_name} #{last_name}"
  end
end
