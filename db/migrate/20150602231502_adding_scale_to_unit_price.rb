class AddingScaleToUnitPrice < ActiveRecord::Migration
  def change
  	change_column :offers, :unitary_price, :decimal, :precision => 10, :scale => 2
  end
end
