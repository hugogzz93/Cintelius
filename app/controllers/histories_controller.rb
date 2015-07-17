class HistoryController < ApplicationController
	def index
		respond_to do |format| 
			format.js {
				@order_histories = current_user.order_histories
			}
		end
	end	
end