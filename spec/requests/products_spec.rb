require 'rails_helper'

RSpec.describe "API_V1::Products", :type => :request do

  let!(:product_1) { Product.create!( :name => "product_1", :price => 100 ) }
  let!(:product_2) { Product.create!( :name => "product_2", :price => 200 ) }

  example "GET /api/v1/products" do

    get "/api/v1/products"

    expect(response).to have_http_status(200)

    expect(response.body).to eq(
      {
        result: [
          {
            url: "http://www.example.com/api/v1/products/#{product_1.id}",
            id: product_1.id,
            name: product_1.name,
            price: product_1.price,
            in_stock_qty: product_1.in_stock_qty,
            image_url: product_1.image_url,
            description: product_1.description,
            created_at: product_1.created_at,
            updated_at: product_1.updated_at
          },
          {
            url: "http://www.example.com/api/v1/products/#{product_2.id}",
            id: product_2.id,
            name: product_2.name,
            price: product_2.price,
            in_stock_qty: product_2.in_stock_qty,
            image_url: product_2.image_url,
            description: product_2.description,
            created_at: product_2.created_at,
            updated_at: product_2.updated_at
          }
        ]
      }.to_json
    )
  end

end