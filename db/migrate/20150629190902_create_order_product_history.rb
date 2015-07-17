class CreateOrderProductHistory < ActiveRecord::Migration
  def change
    create_table :order_product_histories do |t|
	    t.integer  :order_history_id,   limit: 4
	    t.integer  :product_id, limit: 4
	    t.decimal  :units,                precision: 10, scale: 2
	    t.datetime :created_at,                                    null: false
	    t.datetime :updated_at,                                    null: false
    end
  end
end
