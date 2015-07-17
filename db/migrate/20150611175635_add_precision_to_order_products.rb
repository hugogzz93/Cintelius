class AddPrecisionToOrderProducts < ActiveRecord::Migration
  def change
  	change_column :order_products, :units, :decimal, :precision => 10, :scale => 2
  end
end



