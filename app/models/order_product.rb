class OrderProduct < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
	has_one :comment, as: :commentable, dependent: :destroy

	validates :units, presence: true, numericality: true
end
