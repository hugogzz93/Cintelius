class UserProduct < ActiveRecord::Base
	belongs_to :user
	belongs_to :product

	after_create :create_user_product_score

	def create_user_product_score
		self.user.setup_product_score(self.product_id)
	end
end
