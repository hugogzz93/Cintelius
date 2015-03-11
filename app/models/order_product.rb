class OrderProduct < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
	has_one :comment, as: :commentable, dependent: :destroy

	accepts_nested_attributes_for :comment

	validates :units, presence: true, numericality: true
	validates :order_id, uniqueness: { scope: [:product_id],
    message: "Este producto ya se ah escogido para esta orden." }
end
