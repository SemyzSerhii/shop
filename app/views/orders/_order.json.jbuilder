json.extract! order, :id, :user_id, :cart_id, :address, :created_at, :updated_at
json.url order_url(order, format: :json)
