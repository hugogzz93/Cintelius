class OffersController < ApplicationController
	def index
		# No deben de aparecer ordenes que no tengan productos autorizados para el usuario proveedor
		@orders = Order.joins(:order_products, products: :user_products).where(user_id: current_user.id).distinct
	# 	SELECT  DISTINCT orders.* 
	# 	FROM user_products inner join products
	# 		ON user_products.product_id = products.id
	# 		inner JOIN order_products
	# 			ON user_products.product_id = order_products.product_id			
	# 		inner JOIN orders
	# 			ON order_products.order_id = orders.id
	# 		WHERE user_products.user_id = 2

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
