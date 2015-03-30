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

	private
		def combo_params
			params.require(:combo).permit(:order_id, :price, combo_products_attributes: [:product_id, :units], comment_attributes:[:content])
		end
end
