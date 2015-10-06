class OrdersController < ApplicationController

	before_action :authenticate_user!, :check_if_buyer
	def index
		@orders = Order.where(user_id: current_user.id)
	end		

	def new
		@categories = Category.supercategories
		@order = Order.new
		@recent_orders = current_user.order_histories.last(5)
	end

	def create
		# exit
		# params[:order][:due_date] = params[:order][:due_date] + " " +params[:order][:due_time]
		time = ActiveSupport::TimeZone[current_user.time_zone].parse(params[:order][:due_date] + " " +params[:order][:due_time])
		params[:order][:due_date] = time.to_s
		current_user.orders.create(order_params)
		redirect_to root_path
	end

	def edit
			if Order.lock(params[:id], params[:selected_offers_id], params[:selected_combos_id])
				redirect_to root_path, flash: {success: t('order_lock_success')}
			else

				redirect_to root_path, flash: {failure: t('order_lock_failure')}
			end
	end

	def show
		respond_to do |format|
			format.js {
				@order = (Order.where(id: params[:id]).includes(offers: [:comment, :offer_details], combos: :comment, order_products: :comment)).first
				@providers = @order.get_participating_providers
			}
		end
	end

	def destroy
		respond_to do |format|
			format.js {
				@order = Order.find(params[:id])
				@order.create_history_recursively
				@order.destroy
				OrderHistory.where(user_id: current_user.id)[-1].create_review_tickets
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
