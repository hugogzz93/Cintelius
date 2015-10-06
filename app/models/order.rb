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


	# open: usuario puede seleccionar ofertas, locked: ya selecciono, closed: se recibieron los productos

	enum status: [:open, :locked, :closed]

	def due_date_past?
		self.due_date <= Time.zone.now
	end

	def is_locked?
		self.status == "locked"
	end

	def is_open?
		self.status == "open"
	end

	def is_accepting_offers?
		self.is_open? and !self.due_date_past?
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

	# def create_service_review_tickets
	# 	providers = self.get_selected_providers
	# 	providers.each do |provider| 
	# 		self.review_tickets.create(reviewable_type: "ServiceScore", user_id: self.user_id, reviewable_id: provider.service_score.id)
	# 	end
	# end

	def get_participating_providers
		providers_from_offers = self.offers.collect {|offer| offer.user}.uniq
		providers_from_combos = self.combos.collect {|combo| combo.user}.uniq
		providers = providers_from_combos + providers_from_offers
		return providers.uniq
	end


	# proveedores que tienen un producto seleccionado
	def get_selected_providers
		providers_from_offers = self.offers.where(status: Offer.statuses[:locked]).collect {|offer| offer.user}.uniq
		providers_from_combos = self.combos.where(status: Combo.statuses[:locked]).collect {|combo| combo.user}.uniq
		providers = providers_from_combos + providers_from_offers
		return providers.uniq

	end

	# def get_service_review_tickets
	# 	review_tickets = self.review_tickets.where(reviewable_type: "ServiceScore")
	# end

	# def get_product_review_tickets
	# 	review_tickets = self.review_tickets.where(reviewable_type: "ProductScore")
	# end

	def reset

		self.update(status: 0)
		
		self.offers.each do |offer|
			offer.offer_details.each do |a|
				a.update(status: 0)
			end
			offer.update(status: 0)
		end

		self.combos.each do |combo|
			combo.update(status: 0)
		end
	end

	def total_cost
		total = 0
		self.combos.each do |combo|
			total += combo.price
		end
		return total.to_f
	end

	def create_history_recursively
		# los detalles de ofertas son creadas por las ofertas
		history_object_hash = self.attributes
		history_object_hash.delete("id")
		new_order_history = OrderHistory.create(history_object_hash) 
		self.offers.each do |offer|
			offer.create_history_recursively(new_order_history)
		end
		self.combos.each do |combo|
			combo.create_history_recursively(new_order_history)
		end
		self.order_products.each do |order_product|
			order_product.create_history_recursively(new_order_history)
		end
       	self.comment.create_history_recursively(new_order_history)

	end

	def has_combo_from_user(user)
		self.combos.where(user_id: user.id).any?
	end

	def has_selected_combo_from_user(user)
		self.combos.where(user_id: user.id, status: Combo.statuses["locked"]).any?
	end



end
