json.array! @businesses.each do |business|
  json.id business.id
  json.name business.name
  json.shares_sold business.shares_available
  json.owner business.owner.name
end
