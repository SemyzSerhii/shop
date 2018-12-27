json.extract! product, :id, :title, :price, :short_description, :full_description, :preview_image, :in_stock, :created_at, :updated_at
json.url product_url(product, format: :json)
