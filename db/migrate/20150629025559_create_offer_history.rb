class CreateOfferHistory < ActiveRecord::Migration
  def change
    create_table :offer_histories do |t|
    	t.integer  :user_id,       limit: 4
	    t.integer  :product_id,    limit: 4
	    t.integer  :status,        limit: 4,                          default: 0, null: false
	    t.decimal  :unitary_price,           precision: 10, scale: 2,             null: false
	    t.datetime :created_at,                                                   null: false
	    t.datetime :updated_at,                                                   null: false
	    t.integer  :order_history_id,      limit: 4
    end
  end
end
