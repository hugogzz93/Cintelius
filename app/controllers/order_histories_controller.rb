class OrderHistoriesController < ApplicationController
	def show
		respond_to do |format| 
			format.js {
				@order_history = OrderHistory.where(id: params[:id]).includes(user: [:user_detail], combo_histories: [:comment_history, :combo_product_histories], offer_histories: [:comment_history, :offer_detail_histories], order_product_histories: [:comment_history]).first
				@single_combos, @multi_combos = @order_history.table_format
				@product_name_hash = @order_history.get_product_name_hash
			}
			format.json {
				@order_history = OrderHistory.where(id: params[:id]).includes(user: [:user_detail], combo_histories: [:comment_history, :combo_product_histories, user: [:user_detail]], offer_histories: [:comment_history, :offer_detail_histories], order_product_histories: [:comment_history]).first
				@single_combos, @multi_combos = @order_history.get_combos_divided_by_quantity
				@product_name_hash = @order_history.get_product_name_hash
			}
		end
	end
end
