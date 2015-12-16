class CreateTransaction < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.decimal :quantity
      t.integer :type
      t.belongs_to :user
    end
  end
end
