json.result do
  json.array! @orders do |order|
    json.partial! order
  end
end