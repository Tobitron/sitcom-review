class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body
      t.integer :user_id, null: false
      t.integer :sitcom_id
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
