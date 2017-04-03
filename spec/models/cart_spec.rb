require 'rails_helper'

RSpec.describe Cart, type: :model do

  before do
    @cart = Cart.create
    @product = Product.create!( name: "product_1", price: 100)
    @product2 = Product.create!( name: "product_2", price: 150)
  end

  describe "#add_line_item" do
    it "it should add new product to line_items" do
      new_line_item = @cart.add_line_item(@product)
      new_line_item.save

      expect(@cart.line_items.count).to eq(1)

      line_item = @cart.line_items.last
      expect(line_item.product).to eq(@product)
      expect(line_item.quantity).to eq(1)
    end

    it "it should add new product to line_items" do
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

  describe "#total" do
    it "it should sum line_items amount" do
      @cart.add_line_item(@product)
      @cart.add_line_item(@product2)

      expect(@cart.total).to eq(250)
    end
  end
end