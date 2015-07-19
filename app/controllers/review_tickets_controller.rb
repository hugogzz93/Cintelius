class ReviewTicketsController < ApplicationController
	before_action :authenticate_user!

	def index
		respond_to do |format|
			format.js {
				@order_histories = ReviewTicket.get_order_histories_with_review_tickets(current_user.id)
				# current_user.orders.where(status: Order.statuses[:locked]).includes(review_tickets: [:reviewable])
			}
		end
	end
end

