class BusinessSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :shares_available, :created_at, :updated_at

  attributes :owner do |object|
    object.owner.name
  end

  attributes :shares_sold do |object|
    object.shares_sold
  end
end
