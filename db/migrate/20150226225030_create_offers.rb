class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
    	t.belongs_to :user
    	t.belongs_to :product
    	t.integer :status
    	t.decimal :unitary_price

      t.timestamps null: false
    end
  end
end
