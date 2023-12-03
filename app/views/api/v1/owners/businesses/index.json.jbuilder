json.array! @businesses.each do |business|
  json.id business.id
  json.name business.name
  json.shares_sold business.shares_available
  json.owner business.owner.name
  json.total_buy_orders business.buy_orders.count
end
