class CategoriesController < ApplicationController
	
	def update
		respond_to do |format|
			format.js {
				category = Category.find(params[:id])
				if category.update_attributes(category_params)
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
				Category.create(category_params) ? @success = true : @success = false;

			}
		end
	end

	def category_params
		params.require(:category).permit(:supercategory_id, :name)
		
	end

end