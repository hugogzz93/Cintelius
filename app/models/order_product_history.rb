class OrderProductHistory < ActiveRecord::Base
	belongs_to :order_history
	belongs_to :product
	has_one :comment_history, as: :commentable_history, dependent: :destroy

	accepts_nested_attributes_for :comment_history

	validates :units, presence: true, numericality: true
	validates :order_history_id, uniqueness: { scope: [:product_id],
    message: "Este producto ya se ah escogido para esta orden." }

    def get_product_name
    	self.product.name
    end
end
