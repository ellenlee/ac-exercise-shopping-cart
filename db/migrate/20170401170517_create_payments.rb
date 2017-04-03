class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|

      t.integer :order_id
      t.string :payment_method
      t.integer :amount
      t.boolean :paid, default: false
      t.text :params

      t.timestamps null: false
    end

    add_column :orders, :paid, :boolean, default: false
  end
end
