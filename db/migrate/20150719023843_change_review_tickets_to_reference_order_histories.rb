class ChangeReviewTicketsToReferenceOrderHistories < ActiveRecord::Migration
  def change
  	remove_column :review_tickets, :order_id, :integer
  	add_reference :review_tickets, :order_history, index: true
  end
end
