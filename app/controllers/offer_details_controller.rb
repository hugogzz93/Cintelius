class OfferDetailsController < ApplicationController

	before_action :authenticate_user!

	def create
		respond_to do |format|
			format.js {
			# exit
				@offer_detail = OfferDetail.new(offer_details_params)
				@offer_detail.status = "buyer"
				if @offer_detail.save
					@success = true
				else
					@success = false
				end
			}
		end	
	end

	def edit
		exit
		# respond_to do |format|
		# 	format.js {
				
		# 	}
		# end	
	end

	private
	def offer_details_params
		params.require(:offer_detail).permit(:offer_id, :units)
		
	end
end
