class AddUnitaryPriceToComboHistory < ActiveRecord::Migration
  def change
  	 add_column :combo_product_histories, :unitary_price, :decimal, precision: 7, scale: 2, null: false
  end
end
