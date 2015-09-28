class ProductsController < ApplicationController
	before_action :authenticate_user!, :check_if_admin

	def update
		respond_to do |format| 
			format.js {
				product = Product.find(params[:id])
				if product.update_attributes product_params
					@success = true
				else
					@success = false
				end
								
			}
		end
	end	

	def create
		respond_to do |format| 
		format.js {
			Product.create(name: params[:name], category_id: params[:id]) ? @success = true : @success = false
		}
		end
	end

	def product_params
		# params.require(:order).permit(:title, :due_date, comment_attributes: [:content], order_products_attributes: [:product_id, :units, 
		# 	comment_attributes: [:content]])

		params.require(:product).permit(:category_id, :name)
	end

	def check_if_admin
		redirect_to root_path unless current_user.is_admin?
	end
end


