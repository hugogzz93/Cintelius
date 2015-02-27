class SetNotNulls < ActiveRecord::Migration
  def change
  	change_column_null :orders, :title, false
  	change_column_null :offers, :unitary_price, false
  	change_column_null :comments, :content, false
  	change_column_null :combos, :price, false
  	change_column_null :products, :name, false
  	change_column_null :categories, :name, false
  	change_column_null :offer_details, :units, false
  	change_column_null :combo_products, :units, false
  end
end
