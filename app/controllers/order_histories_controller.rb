class OrderHistoriesController < ApplicationController
	def show
		respond_to do |format| 
			format.js {
				@order_history = OrderHistory.where(id: params[:id]).includes(combo_histories: [:comment_history, :combo_product_histories], offer_histories: [:comment_history, :offer_detail_histories], order_product_histories: [:comment_history]).first
				@provider_list = @order_history.get_participating_providers
				@providers_offer_hash = @order_history.sort_offer_histories_by_provider
				@providers_combo_hash = @order_history.sort_combo_histories_by_provider
			}
		end
	end
end
	


