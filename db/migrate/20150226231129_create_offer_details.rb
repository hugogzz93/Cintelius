class CreateOfferDetails < ActiveRecord::Migration
  def change
    create_table :offer_details do |t|
    	t.belongs_to :order
    	t.belongs_to :offer
    	t.integer :units
    	t.integer :status

      t.timestamps null: false
    end
  end
end
