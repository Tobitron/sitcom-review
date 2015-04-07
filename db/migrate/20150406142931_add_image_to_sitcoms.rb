class AddImageToSitcoms < ActiveRecord::Migration
  def change
    add_column :sitcoms, :image, :string
  end
end
