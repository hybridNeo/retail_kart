json.array!(@shops) do |shop|
  json.extract! shop, :id, :shop_name, :address, :category, :owner, :balance
  json.url shop_url(shop, format: :json)
end
