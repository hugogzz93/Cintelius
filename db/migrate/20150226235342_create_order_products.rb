class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
    	t.belongs_to :order
    	t.belongs_to :product
    	t.integer :units

      t.timestamps null: false
    end
  end
end
