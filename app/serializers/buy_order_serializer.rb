class BuyOrderSerializer
  include JSONAPI::Serializer
  attributes :id, :price, :created_at, :updated_at, :quantity, :status

  attributes :buyer do |object|
    object.buyer.name
  end

  attributes :business do |object|
    object.business.name
  end

  attributes :shares_available do |object|
    object.business.shares_available
  end
end
