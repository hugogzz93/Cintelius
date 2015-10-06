class RegistrationsController < Devise::RegistrationsController
	def new
		
		super

	end

	def create
		super
		params[:user_detail][:credentials] = params[:user_detail][:credentials].to_i
		if current_user
			unless current_user.create_user_detail(user_detail_params)
				current_user.destroy
			end
		end
	end

	def update
		super
	end

	def user_detail_params
		params.require(:user_detail).permit!
	end
end