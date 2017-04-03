class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image_url
      t.integer :price, null: false
      t.text :description
      t.integer :in_stock_qty, null: false, default: 0

      t.index :name
      t.timestamps
    end
  end
end
