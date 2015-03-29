json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :shopId, :content, :totalCost, :dueDate
  json.url transaction_url(transaction, format: :json)
end
