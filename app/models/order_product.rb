class OrderProduct < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
	has_one :comment, as: :commentable, dependent: :destroy

	validates :units, presence: true, numericality: true
	validates :order_id, uniqueness: { scope: [:product_id],
    message: "Este producto ya se ah escogido para esta orden." }
end
