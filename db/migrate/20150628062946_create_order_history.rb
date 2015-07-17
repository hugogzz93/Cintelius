class CreateOrderHistory < ActiveRecord::Migration
  def change
    create_table :order_histories do |t|
	    t.string   :title,      limit: 255,             null: false
	    t.integer  :user_id,    limit: 4
	    t.datetime :created_at,                         null: false
	    t.datetime :updated_at,                         null: false
	    t.integer  :status,     limit: 4,   default: 0
	    t.datetime :due_date,                           null: false
	  end
  end
end
