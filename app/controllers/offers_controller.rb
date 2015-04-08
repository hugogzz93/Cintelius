class OffersController < ApplicationController
	def index
		@orders = Order.all
	end

	def new

	end

	def create
		respond_to do |format| 
			format.js {
				@offer = current_user.offers.build(offer_params)
				if @offer.save
					@success = true
				else
					@success = false
				end
			}
		end
	end

	def edit
		respond_to do |format|
			format.js {
				@locked_offers = Offer.lock_offers(Offer.find(params[:selected_offers_id]))
			}
		end
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
