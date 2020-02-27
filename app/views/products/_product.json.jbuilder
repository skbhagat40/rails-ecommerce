json.extract! product, :id, :seller_id, :name, :title, :description, :price, :stock, :vertical, :category, :discount, :created_at, :updated_at
json.url product_url(product, format: :json)
