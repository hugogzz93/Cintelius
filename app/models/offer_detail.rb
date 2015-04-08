class OfferDetail < ActiveRecord::Base
	belongs_to :order
    belongs_to :offer

    validates :units, presence: true, numericality: true
    
    enum status: [:provider, :buyer, :both, :denied_by_provider]
    after_create :bind_to_parent
    after_update :update_offer, if: :buyer?

    def update_offer
        self.offer.update(status: "pending")
    end

    def bind_to_parent
    	# So that it is associated to both, order and offer
    	if self.order_id == nil
    		self.update(order_id: self.offer.order.id)
    	end
    	
    end
end
