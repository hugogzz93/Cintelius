class ChangeComboStatusDefault < ActiveRecord::Migration
  def change
  	change_column_default :combos, :status, 0
  end
end
