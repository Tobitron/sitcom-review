class AddNameIndexToSitcom < ActiveRecord::Migration
  def change
    add_index :sitcoms, :name, unique: true, using: :btree
  end
end
