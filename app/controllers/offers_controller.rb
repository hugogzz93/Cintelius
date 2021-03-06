class OffersController < ApplicationController
	
	before_action :authenticate_user!
	before_filter :check_if_seller, :except => ["update"]
	def index
		# No deben de aparecer ordenes que no tengan productos autorizados para el usuario proveedor
		@orders = Order.joins(:order_products, products: :user_products).where(user_products: {user_id: current_user.id}).distinct
		# SELECT  DISTINCT orders.* 
		# FROM user_products inner join products
		# 	ON user_products.product_id = products.id
		# 	inner JOIN order_products
		# 		ON user_products.product_id = order_products.product_id			
		# 	inner JOIN orders
		# 		ON order_products.order_id = orders.id
		# 	WHERE user_products.user_id = 2
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

	def update
		respond_to do |format|
			format.js {
		# 		@locked_offers = Offer.lock_offers(Offer.find(params[:selected_offers_id]))
				@offer = Offer.find(params[:id])
				unless @offer.update(status: "received") 
					# no funciona esto {
					flash[:failure] = t('order_lock_failure')
					flash.keep[:failure]
					# } puedes quitarlo o tratar de hacer que aparesca el error cuando no se updatee
				end
			}
		end
	end

	def from_order
		respond_to do |format|
			format.js {
				@order = (Order.where(id: params[:id]).includes(:offers, :combos, order_products: :comment)).first
				@products = @order.products
				@authorized_products = current_user.authorized_products
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

		def check_if_seller
			redirect_to orders_path unless current_user.is_seller? or current_user.is_admin?
		end
end
