class OrdersController < ApplicationController

	before_action :authenticate_user!
	def index
		@orders = Order.where(user_id: current_user.id)
	end

	def new
		@categories = Category.where(supercategory_id: nil)
		@order = Order.new
	end

	def create
		params[:order][:due_date] = params[:order][:due_date] + " " +params[:order][:due_time]
		current_user.orders.create(order_params)
		exit		
	end

	def edit
	end

	def show
		respond_to do |format|
			format.js {
				@order = (Order.where(id: params[:id]).includes(offers: :comment, combos: :comment, order_products: :comment)).first
				@providers = User.find(@order.offers.collect {|offer| offer.user_id}.uniq)
			}
		end
	end
	
	private
		def order_params
			params.require(:order).permit(:title, :due_date, order_products_attributes: [:product_id, :units, 
				comment_attributes: [:content]])
		end
		
end
