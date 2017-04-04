json.meta do
  json.url v1_order_url(order)
  json.(order, :created_at, :amount, :payment_method, :payment_status, :order_status, :name, :phone, :address)
end

json.order_items do
  json.array! order.line_items do |item|
    json.product item.product.name
    json.price item.product.price
    json.quantity item.quantity
    json.subtotal item.subtotal
  end
end