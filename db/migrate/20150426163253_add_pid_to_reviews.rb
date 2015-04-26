class AddPidToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :pid, :integer
  end
end
