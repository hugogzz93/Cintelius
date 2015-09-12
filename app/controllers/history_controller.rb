class HistoryController < ApplicationController
	def show
		respond_to do |format| 
			format.js {
				@order_histories = OrderHistory.get_order_histories_hash(Time.now.year, current_user.id)
				# hash con todas las order_histories divididas por mes
			}
		end
	end	
end