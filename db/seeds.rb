# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

# Create 10 users
10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
  )
end

# Create 10 businesses
10.times do
  Business.create!(
    name: Faker::Company.name,
    shares_available: Faker::Number.decimal(l_digits: 2),
    status: "active",
    owner_id: User.ids.sample,
  )
end

# Create 10 buy orders
10.times do
  BuyOrder.create!(
    quantity: Faker::Number.between(from: 1, to: 10),
    price: Faker::Number.decimal(l_digits: 2),
    status: "pending",
    business_id: Business.ids.sample,
    buyer_id: User.ids.sample,
  )
end
