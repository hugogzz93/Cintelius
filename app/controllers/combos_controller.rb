class CombosController < ApplicationController


	def new

	end

	def create
		# current_user.offers.create(offer_params)
		exit
	end

	def from_order
		respond_to do |format|
			format.js {
				@order = (Order.where(id: params[:id]).includes(:offers, :order_products)).first
				@order_products = @order.order_products
				@offers = @order.offers
			}
		end
	end

	private
		def offer_params
			params.require(:offer).permit(:order_id, :product_id, :unitary_price, offer_details_attributes: [:units],
			 comment_attributes: [:content])
		end
end
