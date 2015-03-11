class OrdersController < ApplicationController
	before_action :authenticate_user!
	def index
		@orders = Order.all
	end

	def new
		@categories = Category.where(supercategory_id: nil)
		@order = Order.new
	end

	def create
		order = Order.create(order_params)
		exit
	end

	private
		def order_params
			params.require(:order).permit(:title, order_products_attributes: [:product_id, :units, 
				comment_attributes: [:content]])
		end
		
end
