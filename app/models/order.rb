class Order < ApplicationRecord
  validates_presence_of :name, :email, :address, :phone, :payment_method

  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum payment_method: [ :credit, :atm]
end