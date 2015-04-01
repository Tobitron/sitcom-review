class AddUniquenessIndexToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, [:user_id, :sitcom_id], unique: true
  end
end
