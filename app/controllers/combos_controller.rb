class CombosController < ApplicationController


	def new

	end

	def create
		respond_to do |format| 
			format.js {
				@combo = current_user.combos.build(combo_params)
				if @combo.save
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
				@combo = Combo.find(params[:id])
				unless @combo.update(status: "received") 
					# no funciona esto {
					flash[:failure] = t('order_lock_failure')
					flash.keep[:failure]
					# } puedes quitarlo o tratar de hacer que aparesca el error cuando no se updatee
				end
			}
		end
	end

	private
		def combo_params
			params.require(:combo).permit(:order_id, :price, combo_products_attributes: [:product_id, :units], comment_attributes:[:content])
		end
end
