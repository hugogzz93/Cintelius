class CombosController < ApplicationController


	def new

	end

	def create
		current_user.combos.create(combo_params)
		exit
	end

	private
		def combo_params
			params.require(:combo).permit(:order_id, :price, combo_products_attributes: [:product_id, :units], comment_attributes:[:content])
		end
end
