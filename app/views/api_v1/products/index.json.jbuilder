json.result do
  json.array! @products do |product|
    json.partial! product
  end
end