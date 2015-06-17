class OrdersController < ApplicationController

	before_action :authenticate_user!, :check_if_buyer
	def index
		@orders = Order.where(user_id: current_user.id)
	end		

	def new
		@categories = Category.where(supercategory_id: nil)
		@order = Order.new
	end

	def create
		# importante: se le agrega -0500 por el timezone, falta implementar esto pero para todos los timezones
		params[:order][:due_date] = params[:order][:due_date] + " " +params[:order][:due_time] + " -0500"
		current_user.orders.create(order_params)
	end

	def edit
			if Order.lock(params[:id], params[:selected_offers_id], params[:selected_combos_id])
				# flash[:success] = t('order_lock_success')
				redirect_to root_path, flash: {success: t('order_lock_success')}
			else

				redirect_to root_path, flash: {failure: t('order_lock_failure')}
			end
				# flash.keep(:success)
				# render js: "window.location = '#{order_path(id: params[:id])}'"
	end

	def show
		respond_to do |format|
			format.js {
				@order = (Order.where(id: params[:id]).includes(offers: [:comment, :offer_details], combos: :comment, order_products: :comment)).first
				@providers = User.find(@order.offers.collect {|offer| offer.user_id}.uniq)
			}
		end
	end
	
	private
		def order_params
			params.require(:order).permit(:title, :due_date, comment_attributes: [:content], order_products_attributes: [:product_id, :units, 
				comment_attributes: [:content]])
		end

		def check_if_buyer
			redirect_to offers_path unless current_user.is_buyer? or current_user.is_admin?
		end	
end
