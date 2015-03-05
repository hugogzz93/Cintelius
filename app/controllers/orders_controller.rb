class OrdersController < ApplicationController
	def index
		@orders = Order.all
	end

	def new
		@categories = Category.all
		@order = Order.new
	end
end
