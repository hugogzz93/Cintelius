class ProductScore < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	has_many :review_tickets, as: :reviewable
	validates :user_id, uniqueness: { scope: [:product_id],
    message: "Ya se ha empezado un registro para este usuario." }

end
