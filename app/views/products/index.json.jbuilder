json.array!(@products) do |product|
  json.extract! product, :id, :product_name, :shop_id, :quantity, :bulk_amt, :price, :category, :rating, :shipping
  json.url product_url(product, format: :json)
end
