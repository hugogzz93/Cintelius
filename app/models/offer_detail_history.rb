class OfferDetailHistory < ActiveRecord::Base
	belongs_to :order_history
    belongs_to :offer_history

    validates :units, presence: true, numericality: true
    
    enum status: [:provider, :buyer, :both, :denied_by_provider]

    # after_create :bind_to_parent

    # def update_offer
    #     self.offer.update(status: "pending")
    # end

    # def bind_to_parent
    #     new_offer_id = OfferHistory.last.id + 1
    #     new_order_id = OrderHistory.last.id + 1
    #     self.update(offer_history_id: new_offer_id)
    #     self.update(order_history_id: new_order_id)
    # end

    # def bind_to_parent
    # 	# So that it is associated to both, order and offer
    # 	if self.order_id == nil
    # 		self.update(order_id: self.offer_history.order_history.id)
    # 	end
    # end
end
