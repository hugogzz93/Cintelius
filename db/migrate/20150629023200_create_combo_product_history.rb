class CreateComboProductHistory < ActiveRecord::Migration
  def change
    create_table :combo_product_histories do |t|
	    t.integer  :combo_history_id,   limit: 4
	    t.decimal  :units,                precision: 7, scale: 2, null: false
	    t.datetime :created_at,                                   null: false
	    t.datetime :updated_at,                                   null: false
	    t.integer  :product_id, limit: 4
	  end
  end
end
