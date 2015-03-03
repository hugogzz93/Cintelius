class AddForeignKeyToOffers < ActiveRecord::Migration
  def change
  	add_reference :offers, :order, index: true
  end
end
