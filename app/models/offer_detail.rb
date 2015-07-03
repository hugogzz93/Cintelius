class OfferDetail < ActiveRecord::Base
	belongs_to :order
    belongs_to :offer

    validates :units, presence: true, numericality: true
    
    enum status: [:provider, :buyer, :both, :denied_by_provider]
    after_create :bind_to_parent
    after_update :update_offer, if: :buyer?
    # before_destroy :create_history

    def update_offer
        self.offer.update(status: "pending")
    end

    def bind_to_parent
    	# So that it is associated to both, order and offer
    	if self.order_id == nil
    		self.update(order_id: self.offer.order.id)
    	end
    end

    def create_history_recursively(offer_history_object)
        history_object_hash = self.attributes
        history_object_hash.delete("id")
        history_object_hash.delete("order_id")
        history_object_hash.delete("offer_id")
        history_object_hash["order_history_id"] = offer_history_object.order_history_id
        history_object_hash["offer_history_id"] = offer_history_object.id
        OfferDetailHistory.create(history_object_hash)
    end
end
