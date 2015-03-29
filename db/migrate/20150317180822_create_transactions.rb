class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :shopId
      t.text :content
      t.integer :totalCost
      t.date :dueDate

      t.timestamps
    end
  end
end
