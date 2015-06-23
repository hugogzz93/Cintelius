class ReviewTicket < ActiveRecord::Base
	belongs_to :user
	belongs_to :order
	belongs_to :reviewable, polymorphic: true
	validates :user_id, uniqueness: { scope: [:order_id, :reviewable_id, :reviewable_type],
    message: "Ya puede hacer reseña sobre este producto para esta orden." }

    # crea un review ticket para el producto solo si no se ha hecho previamente
	def self.create_ticket_for_product(order_id, reviewer_id, product_score_id, product_id)
		# verifica que no exista otro review para ese producto de esa orden para ese proveedor
		unless ReviewTicket.where(reviewable_type: "ProductScore", user_id: reviewer_id, order_id: order_id, reviewable_id: product_score_id).any?
			ReviewTicket.create(reviewable_type: "ProductScore", reviewable_id: product_score_id, order_id: order_id, user_id: reviewer_id)	
		end
	end

	def get_reviewee
		self.reviewable.user
	end


end
