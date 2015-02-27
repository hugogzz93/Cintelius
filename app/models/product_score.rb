class ProductScore < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	has_many :review_tickets, as: :reviewable

end
