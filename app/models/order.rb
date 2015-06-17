class Order < ActiveRecord::Base
	belongs_to :user
	has_many :offer_details, dependent: :destroy
	has_many :offers, dependent: :destroy
	has_many :combos, dependent: :destroy
	has_many :order_products, dependent: :destroy
	has_many :products, through: :order_products
	has_one :comment, as: :commentable, dependent: :destroy

	attr_accessor :due_time

	accepts_nested_attributes_for :order_products
	accepts_nested_attributes_for :comment

	validates :title, presence: true, length: {maximum: 100}


	# open: usuario puede seleccionar ofertas, locked: ya selecciono, closed: se termino la orden

	enum status: [:open, :locked, :closed]

	def due_date_past?
		# if due_date <= Time.now
		# 	self.update(status: "choosing_offers")
		# 	return true
		# else
		# 	return false
		# end

		self.due_date <= Time.now
	end

	def is_locked?
		self.status == "locked"
	end

	def is_open?
		self.status == "open"
	end

	def is_closed?
		self.status == "closed"
	end



	def self.lock(order_id, offer_ids, combo_ids)
		Offer.lock_set(offer_ids)
		Combo.lock_set(combo_ids)
		order = Order.find(order_id)
		order.update(status: "locked")
		return 0
	end

	def close
		# pasar al historial
	end

end
