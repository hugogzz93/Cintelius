class OffersController < ApplicationController
	def index
		@orders = Order.all
	end

	def new

	end

	def create
		current_user.offers.create(offer_params)
		exit
	end

	def from_order
		respond_to do |format|
			format.js {
				@order = (Order.where(id: params[:id]).includes(:offers, :combos, order_products: :comment)).first
				@products = @order.products
				@offers = @order.offers.where(user_id: current_user.id)
				@combos = @order.combos.where(user_id: current_user.id)
			}
		end
	end

	private
		def offer_params
			params.require(:offer).permit(:order_id, :product_id, :unitary_price, offer_details_attributes: [:units],
			 comment_attributes: [:content])
		end
end
