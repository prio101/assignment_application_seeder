json.(@buy_order, :id, :status, :quantity, :price)

json.buyer do
  json.id @buy_order.buyer.id
  json.name @buy_order.buyer.name
  json.email @buy_order.buyer.email
end

json.business do
  json.id @buy_order.business.id
  json.name @buy_order.business.name
  json.shares_available @buy_order.business.shares_available
end

json.owner do
  json.id @buy_order.business.owner.id
  json.name @buy_order.business.owner.name
  json.email @buy_order.business.owner.email
end

json.total_buy_orders @buy_order.business.buy_orders.count

json.errors @buy_order.errors, status: :unprocessable_entity
