class ReviewTicket < ActiveRecord::Base
	belongs_to :user
	belongs_to :order_history
	belongs_to :reviewable, polymorphic: true
	validates :user_id, uniqueness: { scope: [:order_history_id, :reviewable_id, :reviewable_type],
    message: "Ya puede hacer reseña sobre este producto para esta orden." }

    # crea un review ticket para el producto solo si no se ha hecho previamente
    # llamado al terminar una orden
	def self.create_ticket_for_product(order_history_id, reviewer_id, product_score_id, product_id)
		# verifica que no exista otro review para ese producto de esa orden para ese proveedor
		unless ReviewTicket.where(reviewable_type: "ProductScore", user_id: reviewer_id, order_history_id: order_history_id, reviewable_id: product_score_id).any?
			ReviewTicket.create(reviewable_type: "ProductScore", reviewable_id: product_score_id, order_history_id: order_history_id, user_id: reviewer_id)	
		end
	end

	def get_reviewee
		self.reviewable.user
	end

	def self.get_order_histories_with_review_tickets(user_id)
		order_histories = []
		ReviewTicket.where(user_id: user_id).each do |review_ticket|
			order_histories << review_ticket.order_history
		end
		order_histories.uniq
	end


end
