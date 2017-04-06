class AddStatusToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :order_status, :integer, default: 0
    add_column :orders, :payment_status, :integer
    add_index :orders, :order_status
    add_index :orders, :payment_status
  end
end
