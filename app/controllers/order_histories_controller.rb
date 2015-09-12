class OrderHistoriesController < ApplicationController
	def show
		respond_to do |format| 
			format.js {
				@order_history = OrderHistory.where(id: params[:id]).includes(combo_histories: [:comment_history, :combo_product_histories], offer_histories: [:comment_history, :offer_detail_histories], order_product_histories: [:comment_history]).first
				@single_combos, @multi_combos = @order_history.categorize_combos
				@product_name_hash = @order_history.get_product_name_hash
			}
		end
	end
end
	


