class AddForeignKeyToReviewTicket < ActiveRecord::Migration
  def change
  	 add_reference :review_tickets, :user, index: true
  end
end
