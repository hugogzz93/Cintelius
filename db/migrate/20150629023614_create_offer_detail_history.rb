class CreateOfferDetailHistory < ActiveRecord::Migration
  def change
    create_table :offer_detail_histories do |t|
    	t.integer  :order_history_id,   limit: 4
	    t.integer  :offer_history_id,   limit: 4
	    t.decimal  :units,                precision: 10, scale: 2,             null: false
	    t.integer  :status,     limit: 4,                          default: 0, null: false
	    t.datetime :created_at,                                                null: false
	    t.datetime :updated_at,                                                null: false
    end
  end
end
