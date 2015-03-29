class CreateProductSellers < ActiveRecord::Migration
  def change
    create_table :product_sellers do |t|
      t.integer :shopId
      t.integer :unitSize
      t.integer :unitCost
      t.integer :stockCur
      t.integer :prodId

      t.timestamps
    end
  end
end
