class Offer < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	belongs_to :order
	has_one :comment, as: :commentable, dependent: :destroy
	has_many :offer_details, dependent: :destroy	

	accepts_nested_attributes_for :offer_details
	accepts_nested_attributes_for :comment

	validates :unitary_price, presence: true, numericality: true
	validate :authorized_product
	after_update :create_review_ticket, if: :received?
	validates :user_id, uniqueness: { scope: [:order_id, :product_id],
    message: "No se puede hacer mas de una oferta para le mismo producto." }

	enum status: [:ready, :pending, :selected, :locked, :received]

	# Falta craer un offer_detail con al craer el offer

	def authorized_product
		authorized_products = self.user.products.collect { |product| product.id}
		errors.add(:product_id, 'Producto no autorizado para esta cuenta.') unless authorized_products.include?(self.product_id)
	end


	def create_offer_details(units, order_id)
		self.offer_details.create(order_id: order_id, units: units)
	end

	def create_review_ticket
		self.user.review_tickets.create(product_id: self.id)
	end

end
