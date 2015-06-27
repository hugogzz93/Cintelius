class ProductScore < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	has_many :review_tickets, as: :reviewable
	validates :user_id, uniqueness: { scope: [:product_id],
    message: "Ya se ha empezado un registro para este usuario." }

    def add_review(review_score, review_ticket_id)

    	ReviewTicket.find(review_ticket_id).destroy

    	if self.total_score
    		total_score = self.total_score + review_score.to_i
    		total_reviews = self.total_reviews + 1
    		self.update(total_score: total_score, total_reviews: total_reviews)
    	else
    		total_reviews = 1
    		self.update(total_score: review_score.to_i, total_reviews: total_reviews)
    	end
    end

end
