class Order < ApplicationRecord
  validates_presence_of :name, :email, :address, :phone, :payment_method

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :payments

  enum payment_method: [ :credit, :atm]
  enum order_status: [ :new_order, :shipped, :cancelled]
  enum payment_status: [ :atm_pending, :atm_paid, :credit_pending, :credit_paid]

  def add_order_items(cart)
    cart.cart_items.each do |item|
      self.order_items.build( product_id: item.product.id,
                              quantity: item.quantity,
                              price: item.product.price )
    end
  end

  def init_status
    if self.payment_method == "atm"
      self.payment_status = "atm_pending"
    else
      self.payment_status = "credit_pending"
    end
  end
end

  def update_payment_status
    if self.paid?
      if self.payment_method == "atm"
        self.payment_status = "atm_paid"
      else
        self.payment_status = "credit_paid"
      end
    end
  end

end
