class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :product_name
      t.text :desc
      t.string :category
      t.integer :rating

      t.timestamps
    end
  end
end
