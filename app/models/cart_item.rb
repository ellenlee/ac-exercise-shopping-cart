class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def subtotal
    self.quantity * self.product.price
  end

end
