json.(@business, :id, :name, :shares_available)

json.total_buy_orders @business.buy_orders.count

json.owner do
  json.id @business.owner.id
  json.name @business.owner.name
  json.email @business.owner.email
end

json.buy_orders @business.buy_orders do |buy_order|
  json.id buy_order.id
  json.status buy_order.status
  json.quantity buy_order.quantity
  json.price buy_order.price
  json.buyer buy_order.buyer.name
end
