class CreateCombos < ActiveRecord::Migration
  def change
    create_table :combos do |t|
    	t.belongs_to :user
    	t.belongs_to :order
    	t.decimal :price
    	t.integer :status

      t.timestamps null: false
    end
  end
end
