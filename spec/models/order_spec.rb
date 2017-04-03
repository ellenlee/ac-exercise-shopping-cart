require 'rails_helper'

RSpec.describe Order, type: :model do

  before do
    @user = User.create!(email: "xxx@example.com", name:"", password: "12345678")
    @cart = Cart.create

    @product = Product.create!( name: "product_1", price: 100)
    @product2 = Product.create!( name: "product_2", price: 150)

    @line_item1 = LineItem.create!( cart_id: @cart.id, product_id: @product.id, quantity: 1)
    @line_item2 = LineItem.create!( cart_id: @cart.id, product_id: @product2.id, quantity: 2)

  end

  describe "#add_line_items" do

    it "it should add line items from cart" do

      order = Order.create!(user_id: 1,
                            name: "test_name",
                            phone: "1234567",
                            address: "test_address",
                            email: "xxx@example.com",
                            payment_method: "credit",
                            amount: @cart.total)

      expect(order.add_line_items(@cart)).to eq(@cart.line_items)
      expect(order.amount).to eq(400) #100+150*2
    end

  end


end