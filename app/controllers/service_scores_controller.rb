class ServiceScoresController < ApplicationController
	before_action :authenticate_user!

	def update
		respond_to do |format|
			format.js {
				@review_ticket_id = params[:review_ticket_id]
				ServiceScore.find(params[:id]).add_review(params[:product_score], params[:review_ticket_id])			
			}
		end
	end
end