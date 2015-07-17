class AddingScaleToUnits < ActiveRecord::Migration
  def change
  	change_column :offer_details, :units, :decimal, :precision => 10, :scale => 2
  end
end
