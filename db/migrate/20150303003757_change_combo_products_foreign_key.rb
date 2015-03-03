class ChangeComboProductsForeignKey < ActiveRecord::Migration
  def change
  	remove_column :combo_products, :products_id
  	add_reference :combo_products, :product, index: true
  end
end
