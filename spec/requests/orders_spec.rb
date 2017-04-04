require 'rails_helper'

RSpec.describe "API_V1::Orders", :type => :request do

  before do
    @user = User.create!(email: "xxx@example.com", password: "12345678")
    @cart = Cart.create

    @product = Product.create!( name: "product_1", price: 100)

    @line_item1 = LineItem.create!( cart_id: @cart.id, product_id: @product.id, quantity: 1)

    @order = Order.create!(user_id: 1, name: "test_name", phone: "1234567",address: "test_address", email: @user.email, payment_method: "credit", amount: @cart.total)

  end

  example "GET /api/v1/orders" do
    @order.add_line_items(@cart)
    @order.init_status
    @order.save!

    get "/api/v1/orders", params: { auth_token: @user.authentication_token }

    data = {
      "result": [
        {
          "meta": {
            "url": "http://www.example.com/api/v1/orders/#{@order.id}",
            "created_at": @order.created_at,
            "amount": 100,
            "payment_method": "credit",
            "payment_status": "credit_pending",
            "order_status": "new_order",
            "name": "test_name",
            "phone": "1234567",
            "address": "test_address"
          },
          "order_items": [
            {
              "product": "product_1",
              "price": 100,
              "quantity": 1,
              "subtotal": 100
            }
          ]
        }
      ]
    }.to_json

    expect(response).to have_http_status(200)
    expect(response.body).to eq(data)
  end

  describe "POST /api/v1/orders" do
    it "create new order" do
      order_params = {
        :name => "order_1", :email => "test@gmail.com", :phone => "123456789", :address => "test_address", :payment_method => "atm"
      }

      post "/api/v1/orders", params: { auth_token: @user.authentication_token, order: order_params }

      expect(@user.orders.last).to eq(Order.last)
      expect(response).to redirect_to("http://www.example.com/api/v1/orders/#{Order.last.id}")
    end

    it "response errors when cannot save" do
      order_params = { :phone => "123456789", :address => "test_address", :payment_method => "atm" }

      post "/api/v1/orders", params: { auth_token: @user.authentication_token, order: order_params }
      error_message = { message: "can't save!" }

      expect(response.body).to eq(error_message.to_json)
    end
  end

end