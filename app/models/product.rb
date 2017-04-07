class Product < ApplicationRecord
  validates_presence_of :name, :price, :in_stock_qty
end
