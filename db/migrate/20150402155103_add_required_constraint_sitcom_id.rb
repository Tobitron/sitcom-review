class AddRequiredConstraintSitcomId < ActiveRecord::Migration
  def change
    change_column_null :reviews, :sitcom_id, false
  end
end
