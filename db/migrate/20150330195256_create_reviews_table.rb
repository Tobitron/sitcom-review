class CreateReviewsTable < ActiveRecord::Migration
  def change
    create_table :reviews_tables do |t|
      t.text :body
      t.integer :user_id, null: false
      t.integer :sitcom_id, null: false
      t.integer :rating, null: false
    end
  end
end
