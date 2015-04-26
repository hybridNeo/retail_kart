class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :uid
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
