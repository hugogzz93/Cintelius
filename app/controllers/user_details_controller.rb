class UserDetailsController < ApplicationController
	before_action :authenticate_user!
	validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

	def edit
		respond_to do |format|
			format.js {
				@user_detail = current_user.user_detail
			}
		end
		
	end

	def update
		respond_to do |format|
			format.js {
				user_detail = UserDetail.find(params[:id])
				if user_detail.update(user_detail_params)
					@success = true
				else
					@success = false
				end
			}
		end
	end

	private
		def user_detail_params
			params.require(:user_detail).permit(:organization, :address, :telephone, :time_zone)
		end

end

