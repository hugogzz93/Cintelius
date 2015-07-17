class AddOrderIdToReviews < ActiveRecord::Migration
  def change
  	add_column :review_tickets, :order_id, :integer
  	change_column_null :review_tickets, :order_id, false
  end
end
