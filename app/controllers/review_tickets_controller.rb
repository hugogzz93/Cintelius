class ReviewTicketsController < ApplicationController
	before_action :authenticate_user!

	def index
		respond_to do |format|
			format.js {
				@orders = current_user.orders.where(status: Order.statuses[:locked]).includes(review_tickets: [:reviewable])
			}
		end
	end
end

