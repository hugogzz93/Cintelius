class UserProductsController < ApplicationController
	before_action :authenticate_user!

	def edit
		respond_to do |format|
			format.js {
				@user_products = current_user.user_products
				@supercategories = Category.supercategories
				@subcategories = Category.subcategories
				@products = Product.all
			}
		end
	end

	def update
		respond_to do |format|
			format.js {
				current_user.user_products.destroy_all
				params[:products].each do |product_id|
					if current_user.user_products.create(product_id: product_id)
						@success = true
					end
				end
			}
		end
	end
end