json.array! @buy_orders do |buy_order|
  json.id buy_order.id
  json.status buy_order.status
  json.quantity buy_order.quantity
  json.price buy_order.price
  json.buyer buy_order.buyer.name

  json.total_buy_orders buy_order.business.buy_orders.count
end
