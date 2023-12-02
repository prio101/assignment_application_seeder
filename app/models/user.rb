class User < ApplicationRecord

  has_secure_password


  validates :name, length: { minimum: 2 }
  validates :email, length: { minimum: 5 }
  validates :password, length: { minimum: 6 }

  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
end
