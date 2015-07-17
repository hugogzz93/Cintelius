class HistoryController < ApplicationController
	def show
		respond_to do |format| 
			format.js {
				@order_histories = current_user.order_histories
			}
		end
	end	
end