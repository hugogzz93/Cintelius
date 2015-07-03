class OrderProduct < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
	has_one :comment, as: :commentable, dependent: :destroy

	accepts_nested_attributes_for :comment

	# before_destroy :create_history

	validates :units, presence: true, numericality: true
	validates :order_id, uniqueness: { scope: [:product_id],
    message: "Este producto ya se ah escogido para esta orden." }


    def create_history_recursively(order_history_object)
        history_object_hash = self.attributes
        history_object_hash.delete("id")
        history_object_hash.delete("order_id")
        history_object_hash["order_history_id"] =  order_history_object.id
       	order_product_history_object = OrderProductHistory.create(history_object_hash)
       	self.comment.create_history_recursively(order_product_history_object)

    end
end
