class Offer < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	belongs_to :order
	has_one :comment, as: :commentable, dependent: :destroy
	has_many :offer_details, dependent: :destroy	

	accepts_nested_attributes_for :offer_details
	accepts_nested_attributes_for :comment

	validates :unitary_price, presence: true, numericality: true
	# validate :authorized_product
	after_update :create_review_ticket, if: :received?
	validates :user_id, uniqueness: { scope: [:order_id, :product_id],
    message: "No se puede hacer mas de una oferta para le mismo producto." }

	enum status: [:ready, :pending, :selected, :locked, :received]

	def is_ready?
		self.status == "ready"
	end

	def is_pending?
		self.status == "pending"
	end

	def is_selected?
		self.status == "selected"
	end

	def is_locked?
		self.status == "locked"
	end

	def is_received?
		self.status == "received"
	end

	def detail_status
		self.offer_details.last.status
	end

	def complete_status
		if self.is_ready? and detail_status == "both"
			"ready-both"
		elsif self.is_ready? and detail_status == "provider"
			"ready-provider"
		elsif self.is_pending?
			# se hizo una contraoferta y espera decision de proveedor
			"pending"
		elsif self.is_selected?
			# ambos aceptaron y comprador la selecciono la
			"selected"
		elsif self.is_locked?
			#despues de ser seleccionada, ya se confirmo y no se puede cambiar
			"locked"
		elsif self.is_received?
			"received"			
		end
	end

	def units
		self.offer_details.last.units
	end

	def total_price
		self.units * self.unitary_price
	end

	def organization
		self.user.user_detail.organization
	end

	def product_name
		self.product.name
	end

	

	# Falta craer un offer_detail con al craer el offer

	def authorized_product
		authorized_products = self.user.products.collect { |product| product.id}
		errors.add(:product_id, 'Producto no autorizado para esta cuenta.') unless authorized_products.include?(self.product_id)
	end


	# def create_offer_details(units, order_id)
	# 	self.offer_details.create(order_id: order_id, units: units)
	# end

	def create_review_ticket
		product_score_id = ProductScore.where(product_id: self.product_id, user_id: self.user_id).first.id
		ReviewTicket.create_ticket_for_product(self.order_id, self.order.user_id, product_score_id, self.product_id)
	end

	def self.lock_set(offers_ids) 
	#le cambie el nombre de lock_offer para ver donde se utiliza, 
	# tambien la altere para que ahora reciba ids en vez de ofertas
	return unless offers_ids
		offers_ids.each do |offer_id|
			offer = Offer.find(offer_id)
			if offer.offer_details.last.status == "provider"
				offer.update(status: "locked")
				offer.offer_details.last.update(status: "both")
			end
		end
		
	end

end
