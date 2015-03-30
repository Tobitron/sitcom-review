class CreateSitcoms < ActiveRecord::Migration
  def change
    create_table :sitcoms do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.integer :start_year, null: false
      t.integer :end_year
      t.string :genre
      t.string :network
      t.timestamps
    end
  end
end
