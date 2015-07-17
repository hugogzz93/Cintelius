class AddPrecisionToComboUnits < ActiveRecord::Migration
  def change
  	change_column :combos, :price, :decimal, :precision => 10, :scale => 2
  	change_column :combo_products, :units, :decimal, :precision => 7, :scale => 2
  end
end
