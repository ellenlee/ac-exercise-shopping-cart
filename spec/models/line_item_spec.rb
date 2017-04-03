require 'rails_helper'

RSpec.describe LineItem, type: :model do

  before do
    @cart = Cart.create
    @product = Product.create!( name: "product_1", price: 100)
    @product2 = Product.create!( name: "product_2", price: 150)
  end

  describe "#subtotal" do
    it "it should quantity x product's' price" do
      new_line_item1 = @cart.add_line_item(@product)
      new_line_item1.save

      new_line_item2 = @cart.add_line_item(@product)
      new_line_item2.save

      expect(@cart.line_items.count).to eq(1)
      line_item = @cart.line_items.last
      expect(line_item.product).to eq(@product)
      expect(line_item.quantity).to eq(2)
    end
  end

end