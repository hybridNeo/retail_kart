class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :shop_id
      t.integer :quantity
      t.integer :bulk_amt
      t.integer :price
      t.string :category
      t.integer :rating
      t.string :shipping

      t.timestamps
    end
  end
end
