class UserSettingsController < ApplicationController
	before_action :authenticate_user!

	def index
		@user_id = current_user.id
	end

end


