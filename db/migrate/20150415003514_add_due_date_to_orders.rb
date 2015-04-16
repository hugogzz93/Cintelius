class AddDueDateToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :due_date, :datetime
  	change_column_null :orders, :due_date, false
  end
end
