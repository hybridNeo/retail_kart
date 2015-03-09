class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :shop_name
      t.string :address
      t.string :category
      t.string :owner
      t.integer :balance

      t.timestamps
    end
  end
end
