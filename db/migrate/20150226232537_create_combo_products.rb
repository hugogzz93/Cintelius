class CreateComboProducts < ActiveRecord::Migration
  def change
    create_table :combo_products do |t|
    	t.belongs_to :combo
    	t.belongs_to :products
    	t.integer :units

      t.timestamps null: false
    end
  end
end
