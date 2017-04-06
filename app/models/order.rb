class Order < ApplicationRecord
  validates_presence_of :name, :email, :address, :phone, :payment_method

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum payment_method: [ :credit, :atm]

  def add_order_items(cart)
    cart.cart_items.each do |item|
      self.order_items.build( product_id: item.product.id,
                              quantity: item.quantity,
                              price: item.product.price )
    end
  end


end