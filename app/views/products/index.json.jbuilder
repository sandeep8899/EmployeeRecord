json.array!(@products) do |product|
  json.extract! product, :id, :name, :inventory_time
  json.url product_url(product, format: :json)
end
