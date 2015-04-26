class AddRcountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rCount, :integer
  end
end
