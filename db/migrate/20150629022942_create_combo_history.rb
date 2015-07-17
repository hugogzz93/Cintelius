class CreateComboHistory < ActiveRecord::Migration
  def change
    create_table :combo_histories do |t|
	    t.integer  :user_id,    limit: 4
	    t.integer  :order_history_id,   limit: 4
	    t.decimal  :price,                precision: 10, scale: 2,             null: false
	    t.integer  :status,     limit: 4,                          default: 0, null: false
	    t.datetime :created_at,                                                null: false
	    t.datetime :updated_at,                                                null: false
	  end
  end
end
